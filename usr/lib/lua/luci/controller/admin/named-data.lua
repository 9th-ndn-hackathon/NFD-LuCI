module("luci.controller.admin.named-data", package.seeall)

function index()
  page = node("admin", "named-data")
  page.target = firstchild()
  page.title  = _("NDN")
  page.order  = 80
  page.index  = true

  page = node("admin", "named-data", "face-list")
  page.target = template("named-data/face-list")
  page.title  = _("Face List")
  page.order  = 40

  page = entry({"admin", "named-data", "nfd-config"})
  page.target = firstchild()
  page.title = _("NFD Configuration")
  page.order = 50

  page = entry({"admin", "named-data", "nfd-config", "general"})
  page.target = cbi("named-data/general")
  page.title = _("General Settings")
  page.order = 10

  page = entry({"admin", "named-data", "nfd-config", "strategy"})
  page.target = cbi("named-data/strategy")
  page.title = _("Strategy Choice")
  page.order = 50

  page = node("admin", "named-data", "ndnping")
  page.target = template("named-data/ndnping")
  page.title  = _("ndnping")
  page.order  = 60

  page = entry({"admin", "named-data", "diag_ndnping"}, post("diag_ndnping"), nil)
  page.leaf = true

  page = entry({"admin", "named-data", "add-face-temp"}, post("add_face_temp"), nil)
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

function add_face_temp(cmd)
  local addr = luci.http.formvalue("addr")
  local util = io.popen("/etc/init.d/nfd connect %s" % luci.util.shellquote(addr))

  luci.http.redirect('face-list')
end

