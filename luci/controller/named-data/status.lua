module("luci.controller.named-data.status", package.seeall)

function index()
  page = node("admin", "status", "named-data")
  page.target = firstchild()
  page.title  = _("NDN")
  page.order  = 70
  page.index  = true

  page = node("admin", "status", "named-data", "general")
  page.target = template("named-data/status-general")
  page.title  = _("NFD Status")
  page.order  = 10

  page = entry({"admin", "named-data", "displayCountersNDN"}, post("displayCountersNDN"), nil)
  page.leaf = true

  page = node("admin", "status", "named-data", "faces")
  page.target = template("named-data/status-faces")
  page.title  = _("Faces")
  page.order  = 20

  page = node("admin", "status", "named-data", "routes")
  page.target = template("named-data/status-routes")
  page.title  = _("Routes")
  page.order  = 30

  
  page = entry({"admin", "status", "named-data", "create_face"}, post("create_face"), nil)
  page.leaf = true
end

function create_face()
  local addr = luci.http.formvalue("addr")
  local util = io.popen("/etc/init.d/nfd connect %s" % luci.util.shellquote(addr))
  luci.http.redirect("faces")
end


function displayCountersNDN(cmd)

  local prefix = luci.http.formvalue("q")
  luci.http.prepare_content("text/plain")

  local util = io.popen("nfdc status show")
  if util then
    local mapper = {}
    while true do
      local ln = util:read("*l")
      s = ltrim(tostring(ln))
      local splitline = split(tostring(s), "=")

      if (#(splitline) > 1) then
      mapper[tostring(splitline[1])] = tostring(splitline[2])

    end 

      if not ln then break end
    end
    desiredList = {"nFibEntries", "nPitEntries", "nMeasurementEntries", "nCsEntries", "nInInterests", "nOutInterests", "nInData", "nOutData", "nInNacks","nOutNacks", "nSatisfiedInterests","nUnsatisfiedInterests"}
    dictSize = #(desiredList)
    mapSubset = {}
    for i = 1, dictSize, 1 do
      mapSubset[desiredList[i]] = mapper[desiredList[i]]
    end

    luci.http.write(luci.json.encode(mapSubset))
    util:close()
  end

end


--not using luci's split function because when used on the equals sign as relevant for grabbing counters only grabs the first half e.g. "nFibEntries:"

function split(s, sep)
  local fields = {}

  local sep = sep or " "
  local pattern = string.format("([^%s]+)", sep)
  string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

  return fields
end

function ltrim(s)
  return (s:gsub("^%s*", ""))
end