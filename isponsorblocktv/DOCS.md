# Home Assistant App: iSponsorBlockTV

iSponsorBlockTV runs [dmunozv04/iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV) inside Home Assistant OS. It connects to YouTube TV clients and uses SponsorBlock to skip sponsor, intro, outro, and other configured segments. It can also mute or skip YouTube ads when the YouTube TV client supports it.

## What it does

- Skips configured SponsorBlock categories on YouTube TV devices
- Supports multiple YouTube TV clients
- Can skip and/or mute YouTube ads
- Supports optional channel whitelisting
- Uses host networking so device discovery and local device communication work from Home Assistant OS

## First-time setup

The app needs at least one YouTube TV `screen_id` before it can start.

1. On your YouTube TV app, open **Settings -> Link with TV code** or the TV link screen.
2. Use the upstream setup helper on another Linux machine or any Docker host to create a config:

   ```sh
   rm -rf /tmp/isponsorblocktv-config
   mkdir /tmp/isponsorblocktv-config
   docker run --rm -it \
     -v /tmp/isponsorblocktv-config:/app/data \
     --net=host \
     ghcr.io/dmunozv04/isponsorblocktv --setup-cli
   cat /tmp/isponsorblocktv-config/config.json
   ```

3. Copy each device's `screen_id`, `name`, and optional `offset` into the Home Assistant app configuration.
4. Start the app.

## Configuration

All options are set from **Settings -> Apps/Add-ons -> iSponsorBlockTV -> Configuration**.

| Option | Type | Default | Description |
|---|---|---|---|
| `timezone` | string | `Europe/Sofia` | Container timezone. |
| `apikey` | password | empty | Optional YouTube Data API key. Some upstream features may require it. |
| `devices` | list | empty | YouTube TV devices. Each item needs `screen_id`; `name` and `offset` are optional. |
| `skip_categories` | list | `sponsor` | SponsorBlock categories to skip. Common values: `sponsor`, `selfpromo`, `interaction`, `intro`, `outro`, `preview`, `filler`, `music_offtopic`, `exclusive_access`. |
| `skip_count_tracking` | boolean | `true` | Report skips to SponsorBlock statistics. |
| `mute_ads` | boolean | `true` | Mute YouTube ads where supported. |
| `skip_ads` | boolean | `true` | Press the YouTube "Skip Ad" button when it becomes available. |
| `minimum_skip_length` | integer | `1` | Minimum segment length, in seconds, before skipping. |
| `auto_play` | boolean | `true` | Let iSponsorBlockTV auto-play where upstream supports it. |
| `join_name` | string | `iSponsorBlockTV` | Name used by iSponsorBlockTV when joining YouTube TV sessions. |
| `channel_whitelist` | list | empty | Channels that should not be skipped. Each item uses `id` and optional `name`. |
| `use_proxy` | boolean | `false` | Passes the upstream proxy flag through the generated config. |

Example `devices` entry:

```yaml
- screen_id: ABCD-EFGH-IJKL
  name: Living Room TV
  offset: 0
```

## Troubleshooting

### The app exits immediately

Make sure the `devices` list contains at least one item with a non-empty `screen_id`.

### Device discovery does not find anything

The app uses host networking, but discovery still depends on your Home Assistant host and YouTube TV device being on the same network/VLAN during setup. If discovery does not work, use the manual TV code flow and copy the generated `screen_id` into the app configuration.

### Segments are not skipped

Check the app logs for connection errors, verify that your `screen_id` is current, and confirm the video has matching segments in the SponsorBlock database. YouTube periodically changes TV pairing behavior, so you may need to pair the device again.

### Ads are not muted

Ad muting depends on the client. For example, upstream notes that Apple TV ad muting does not work when audio is sent to another speaker via AirPlay.
