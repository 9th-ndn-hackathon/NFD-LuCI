m = Map("nfd", translate("NFD - Saved Faces"),
        translate("Write down faces that are stored and automatically created."))

s = m:section(TypedSection, "face", translate("Saved Face"))
s.addremove = true
s.anonymous = true
s.template = "cbi/tblsection"

function s.filter(self, section)
  return self.map:get(section, "use_autoconfig") ~= "1"
end

remote_uri = s:option(Value, "remote", translate("Prefix"))
remote_uri.datatype = "string"
remote_uri.rmempty  = true

routes = s:option(DynamicList, "route", translate("Routes"))
routes.datatype = "string"
routes.rmempty  = true

return m

