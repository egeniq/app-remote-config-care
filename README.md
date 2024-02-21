# AppRemoteConfig

Configure apps remotely: A simple but effective way to manage apps remotely.

Create a simple configuration file that is easy to maintain and host, yet provides important flexibility to specify settings based on your needs.

## CLI Utility

Use the `care` CLI utility to initialize, verify, resolve and prepare configuration files.

To install use:

    brew install egeniq/app-utilities/care

## Schema

The JSON/YAML schema is defined [here](https://raw.githubusercontent.com/egeniq/app-remote-config/main/Schema/appremoteconfig.schema.json).

## Usage

The `care` command line utility has built-in help available.

   care --help
   
There are four subcommands to use: init, verify, resolve and prepare.

### Init

Create a new configuration file:

   care init appconfig.yaml
   
This will create a new file:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/egeniq/app-remote-config/main/Schema/appremoteconfig.schema.json
$schema: https://raw.githubusercontent.com/egeniq/app-remote-config/main/Schema/appremoteconfig.schema.json

# Settings for the current app.
settings:
  foo: 42
  coolFeature: false

# Keep track of keys that are no longer in use.
deprecatedKeys:
- bar

# Override settings
overrides:
- matching:
  # If any of the following combinations match
  - appVersion: <=0.9.0
    platform: Android
  - appVersion: <1.0.0
    platform: iOS
  - platformVersion: <15.0.0
    platform: iOS.iPad
  # These settings get overriden.
  settings:
    bar: low
 
# Or release a new feature at a specific time
- schedule:
    from: '2024-12-31T00:00:00Z'
  settings:
    coolFeature: true
    
# Store metadata here
meta:
  author: Your Name
```

Under the `settings` key you would put the current settings you want in your app. If any keys are deprecated, add them to the `deprecatedKeys` array so they can still be overriden.

In `overrides` you can define settings that vary on a number of factors such as appVersion, platform, platformVersion. See help for the full list of options. If one of the combinations match, the settings are override the settings from the root `settings` key. Settings are applied from top to bottom.

You can also schedule changes in settings. If you add a `schedule` with `from` and/or `until` ISO8601 dates settings will only be applied if the current time lies with the range. Omitting `from` means using the distant past, and omitting `to` means using the distant future.

The keys under `meta` are not used, but only exist to keep track of metadata.

### Verify

If your editor supports it, the JSON schema helps you to properly format the config file. You can further verify correctness of a config file by running:

    care verify appconfig.yaml
    
### Resolve

To check that settings and overrides you have setup are correct, you can ask `care` to show how the settings would resolve.

    care resolve appconfig.yaml -p iOS --platform-version 16  -v 1.0.1
    
That would show something like this:
    
```    
Resolving for:
  platform            : iOS
  platform version    : 16.0.0
  app version         : 1.0.1
  build variant       : release

Settings on 2024-02-22 11:40:00 +0000:
  coolFeature         : false
  foo                 : 42

Settings on 2024-12-31 00:00:00 +0000:
  coolFeature         : false -> true
  foo                 : 42

No further overrides scheduled.
```

### Prepare

The last step is convert the config file to compact json.

   care prepare appconfig.yaml appconfig.json

The file `appconfig.json` is now ready to made available to your app via a webserver.
