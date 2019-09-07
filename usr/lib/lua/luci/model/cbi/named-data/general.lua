m = Map("nfd", translate("NFD - General Settings"),
        translate("Enter general NFD settings."))

s = m:section(NamedSection, "cs", "cs", translate("Content Store"))
s.anonymous = true
s.addremove = false

capacity = s:option(Value, "capacity", translate("Capacity"))
capacity.datatype = "range(0, 65536)"
capacity.default = 2048

policy = s:option(ListValue, "policy", translate("Policy"))
policy:value("lru", "Least Recently Used")
policy:value("priority_fifo", "priority FIFO")
policy.default = "lru"
policy.widget = "select"
policy.size = 1

s = m:section(NamedSection, "face_system", "face_system", translate("Face System"))
s.anonymous = true
s.addremove = false

s:option(Flag, "ether_listen", translate("Ethernet unicast"))
s:option(Flag, "ether_mcast", translate("Ethernet multicast"))
s:option(Flag, "udp_listen", translate("UDP unicast"))
s:option(Flag, "udp_mcast", translate("UDP multicast"))
s:option(Flag, "tcp_listen", translate("TCP listener"))
s:option(Flag, "ws_listen", translate("WebSocket listener"))

return m
