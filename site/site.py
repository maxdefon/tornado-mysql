#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
import torndb
import MySQLdb.constants


class HomeHandler(tornado.web.RequestHandler):

    def get(self):
        db = torndb.Connection("localhost", "redis", "root", "vagrant")
        itens = db.query("SELECT * FROM itens")
        self.render("static/home.html", itens=itens)

settings = {
    "autoreload": True,
    "debug": True,
}


application = tornado.web.Application([
    (r"/", HomeHandler),
], **settings)




if __name__ == "__main__":
    application.listen(9999)
    tornado.ioloop.IOLoop.instance().start()
