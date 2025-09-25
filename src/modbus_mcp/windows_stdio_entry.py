from modbus_mcp.server import ModbusMCP

def main() -> None:
    # Run Modbus MCP over stdio for MCP clients (Windows-friendly)
    ModbusMCP().run(transport="stdio", show_banner=False)

if __name__ == "__main__":
    main()
