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

  page = node("admin", "named-data", "strategy")
  page.target = cbi("named-data/strategy")
  page.title = _("Strategy Choice")
  page.order = 50

  page = node("admin", "named-data", "ndnping")
  page.target = template("named-data/ndnping")
  page.title  = _("ndnping")
  page.order  = 60

  page = entry({"admin", "named-data", "diag_ndnping"}, post("diag_ndnping"), nil)
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
