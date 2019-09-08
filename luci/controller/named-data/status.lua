module("luci.controller.named-data.status", package.seeall)

function index()
  page = node("admin", "status", "named-data")
  page.target = firstchild()
  page.title  = _("NDN")
  page.order  = 70
  page.index  = true

  page = node("admin", "status", "named-data", "general")
  page.target = template("named-data/status-general")
  page.title  = _("NFD General Status")
  page.order  = 10

  page = node("admin", "status", "named-data", "faces")
  page.target = template("named-data/status-faces")
  page.title  = _("NFD Faces")
  page.order  = 20

  page = entry({"admin", "status", "named-data", "create_face"}, post("create_face"), nil)
  page.leaf = true
end

function create_face()
  local addr = luci.http.formvalue("addr")
  local util = io.popen("/etc/init.d/nfd connect %s" % luci.util.shellquote(addr))
  luci.http.redirect("faces")
end

