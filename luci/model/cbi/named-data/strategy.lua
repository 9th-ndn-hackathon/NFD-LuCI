m = Map("nfd", translate("NFD - Strategy Choices"),
        translate("These forwarding strategy choices are applied when NFD service starts."))

s = m:section(TypedSection, "strategy", translate("Strategy Choices"))
s.addremove = true
s.anonymous = true
s.template = "cbi/tblsection"

prefix = s:option(Value, "prefix", translate("Prefix"))
prefix.datatype = "string"
prefix.rmempty  = true

strategy = s:option(ListValue, "strategy", translate("Strategy"))
strategy:value("multicast", "multicast")
strategy:value("best-route", "best route")
strategy:value("asf", "ASF (Adaptive SRTT-based Forwarding)")
strategy:value("self-learning", "self-learning")
strategy.default = "multicast"
strategy.widget = "select"
strategy.size = 1

return m
