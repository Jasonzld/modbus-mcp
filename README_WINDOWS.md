# Modbus-MCP on Windows (Fork Enhancements)

This fork adds first-class Windows support:

- `windows_stdio_entry.py`: runs Modbus MCP over stdio for MCP clients (e.g., Codex CLI) so the server handshakes immediately without opening ports.
- `install_windows.ps1`: creates a Python 3.13 virtualenv (via `uv` if available), installs this package (`-e .`), and prints how to launch the stdio entry.
- Optional environment defaults to avoid reading devices.json: set `MODBUS_MCP_MODBUS__HOST`, `MODBUS_MCP_MODBUS__PORT`, `MODBUS_MCP_MODBUS__UNIT`.

## Quick start
```powershell
# From repo root
./install_windows.ps1   # optional: -Venv .venv-modbus

# Then run stdio entry (for Codex/Claude MCP clients):
C:\path\to\.venv-modbus\Scripts\python.exe -m modbus_mcp.windows_stdio_entry
```

## Codex CLI integration (Windows)
In `C:\Users\<you>\.codex\config.toml`:
```toml
[mcp_servers.modbus]
command = "C:\\Users\\<you>\\.codex\\Tools\\.venv-modbus\\Scripts\\python.exe"
args = ["E:\\XXXX\\G491_WaterQ_V2\\Tools\\MCP\\modbus-mcp\\src\\modbus_mcp\\windows_stdio_entry.py"]

[mcp_servers.modbus.env]
MODBUS_MCP_MODBUS__HOST = "127.0.0.1"
MODBUS_MCP_MODBUS__PORT = "15020"
MODBUS_MCP_MODBUS__UNIT = "1"
```
Reload Codex (`reload-config`) and verify with `list-tools`.

## Local simulator (optional)
Use a simple Modbus TCP slave at 127.0.0.1:15020 for smoke tests:
```powershell
E:\XXXX\G491_WaterQ_V2\Tools\validation\start_modbus_sim.ps1
```
