m = Map("nfd", translate("NFD - Permanent Faces"),
        translate("These faces and routes are created when NFD service starts."))

s = m:section(TypedSection, "face", translate("Regular Faces"))
s.addremove = true
s.anonymous = true
s.template = "cbi/tblsection"
function s.filter(self, section)
  return self.map:get(section, "use_autoconfig") ~= "1"
end

remote = s:option(Value, "remote", translate("Prefix"))
remote.datatype = "string"
remote.rmempty  = true

route = s:option(DynamicList, "route", translate("Routes"))
route.datatype = "string"
route.rmempty  = true

return m
