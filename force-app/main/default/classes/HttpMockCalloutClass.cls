global class HttpMockCalloutClass implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody('SUCCESS FAKE RESPONSE');
        res.setStatusCode(200);
        return res;
    }
}