module("luci.controller.named-data.config", package.seeall)

function index()
  page = entry({"admin", "network", "nfd"})
  page.target = firstchild()
  page.title = _("NFD")
  page.order = 70

  page = entry({"admin", "network", "nfd", "general"})
  page.target = cbi("named-data/general")
  page.title = _("General Settings")
  page.order = 10

  page = entry({"admin", "network", "nfd", "face"})
  page.target = cbi("named-data/face")
  page.title = _("Permanent Faces")
  page.order = 20

  page = entry({"admin", "network", "nfd", "strategy"})
  page.target = cbi("named-data/strategy")
  page.title = _("Strategy Choice")
  page.order = 30

  page = node("admin", "network", "nfd", "ndnping")
  page.target = template("named-data/ndnping")
  page.title  = _("Diagnostics")
  page.order  = 40

  page = entry({"admin", "network", "nfd", "diag_ndnping"}, post("diag_ndnping"), nil)
  page.leaf = true
end

function diag_ndnping(cmd)
  local prefix = luci.http.formvalue("q")
  luci.http.prepare_content("text/plain")

  local util = io.popen("ndnping -c 4 %s" % luci.util.shellquote(prefix))
  if util then
    while true do
      local ln = util:read("*l")
      if not ln then break end
      luci.http.write(ln)
      luci.http.write("\n")
    end

    util:close()
  end
end
