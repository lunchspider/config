require 'arduino-nvim'.setup {
    default_fqbn = "arduino:avr:uno",

    --Path to clangd (all paths must be full)
    clangd = require('mason-core.path').bin_prefix('clangd'),

    --Path to arduino-cli
    arduino = os.getenv('HOME') .. '/.local/bin/arduino-cli',

    --Data directory of arduino-cli
    arduino_config_dir = os.getenv('HOME') .. "/.arduino15/arduino-cli.yaml",
}

