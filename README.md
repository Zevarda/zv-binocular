🔭 QBCore Binoculars Script

A lightweight and immersive binocular script for **QBCore** servers, designed with usability and compatibility in mind.


## ✨ Features

- ✅ **Zoom In/Out** with mouse scroll
- ✅ **Switch Vision Modes** (Normal → Night Vision → Thermal Vision) with `E`
- ✅ **Smooth Camera Movement** with mouse
- ✅ **Exit with ESC or reuse item**
- ✅ **Clean NUI HUD** for instructions
- ✅ Works with `qb-inventory`, `ox_inventory`, and `qs-inventory`


 🔧 Installation

1. **Download or clone** this repository into your server's `resources/` folder.

2. Add to your `server.cfg`:

```
ensure binoculars
```


3. Make sure you have this item in `qb-core/shared/items.lua`:
```lua
['binoculars'] = {
    name = 'binoculars',
    label = 'Binoculars',
    weight = 100,
    type = 'item',
    image = 'binoculars.png',
    unique = true,
    useable = true,
    shouldClose = true,
    description = 'Zoom Zoom.'
}
```

4. Done! Use `/giveitem [id] binoculars 1` or buy it via shop.

🎮 Controls

| Key        | Function            |
| ---------- | ------------------- |
| `Scroll`   | Zoom In/Out         |
| `E`        | Toggle Vision Mode  |
| `ESC`      | Exit Binocular View |
| `Use item` | Reuse to Exit       |


