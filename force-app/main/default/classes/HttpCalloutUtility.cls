public with sharing class HttpCalloutUtility {
    public static HttpResponse sendHttpRequest(String endpoint, String method, String requestBody) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        if (requestBody != null) {
            request.setBody(requestBody);
        }

        Http http = new Http();
        return http.send(request);
    }
}