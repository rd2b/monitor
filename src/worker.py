#!/usr/bin/env python

""" worker.py : Description """

__author__ = "Remi Debay"
__date__ = "2013/01/31"


import threading

from google.appengine.ext import db

class Data(db.Model):
    level = db.IntegerProperty()
    test = db.StringProperty()
    reference = db.StringProperty() 
    timestamp = db.IntegerProperty()
    data = db.StringProperty(multiline = True)

class Reference(db.Model):
    pass

class Test(db.Model):
    pass


class Storage:
    def __init__(self):
        pass

    def gettest(self, name):
        test = Test.get_or_insert(name)
        return test

    def getreference(self, name):
        reference = Reference.get_or_insert( name)
        return reference



    def append(self, level, test, reference, timestamp, data):
        newdata = Data()
        mytest = self.gettest(test)
        myreference = self.getreference(reference)
        
        newdata.level = int(level)
        newdata.test = str(mytest.key().name())
        newdata.reference = str(myreference.key().name())
        newdata.timestamp = int(timestamp)
        newdata.data = str(data)

        newdata.put()
        
    def datas(self):
        datas = Data.all()
        return datas

    def tests(self):
        tests = Test.all()
        results = []
        for test in tests:
            print(test.key().name())
            if not test.key().name() in results:
                results.append(test.key().name())
        return results

    def references(self):
        references = Reference.all()
        results = []
        for reference in references:
            print(reference.key().name())
            if not reference.key().name() in results:
                results.append(reference.key().name())
        return results


    def lastsdatas(self):
        datas = self.datas()

        last = {}
        for data in datas:
            if not data.reference in last :
                last[data.reference] = {}
            if not data.test in last[data.reference]:
                last[data.reference][data.test] = data
            elif  last[data.reference][data.test].timestamp < data.timestamp:
                last[data.reference][data.test] = data
        return last


    def __str__(self):
        response = []
        datas = self.datas()
        for data in datas:
            response.append(str(data))
        return str(response)
