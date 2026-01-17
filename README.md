# playdate-runcat

RunCat endless game for [Playdate](https://play.date). This project is written in Embedded Swift using [PlaydateKit](https://github.com/finnvoor/PlaydateKit).

## Requirements

- macOS 14 or later
- Swift 6.2+ (Xcode 26+)
- [Playdate SDK](https://play.date/dev/)
- [PlaydateKit](https://github.com/finnvoor/PlaydateKit) (as a sibling directory `../PlaydateKit`)

## How to build

```bash
swift package pdc
```

The built `.pdx` file will be located at:

```
.build/plugins/PDCPlugin/outputs/RunCat.pdx
```

> **Note**: Building from Xcode by opening `Package.swift` is not supported. Xcode does not support the toolset configuration required for Embedded Swift on Playdate. Use the command line instead.

### Build options

- `--device-only`: Build only for Playdate hardware (skips simulator build)
- `--simulator-only`: Build only for the simulator
- `--verbose`: Show detailed build output

## How to run on the simulator

```bash
open -a "Playdate Simulator" .build/plugins/PDCPlugin/outputs/RunCat.pdx
```

Or open the `.pdx` file directly from the Playdate Simulator app.
