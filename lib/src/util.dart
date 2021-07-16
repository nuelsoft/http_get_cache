import 'package:http/http.dart';

extension ResponseToJson on Response {
  Map<String, dynamic> get json => {
        "body": this.body,
        "statusCode": this.statusCode,
        "headers": this.headers,
        "isRedirect": this.isRedirect,
        "persistentConnection": this.persistentConnection,
        "reasonPhrase": this.reasonPhrase,
      };
}

extension MapToResponse on Map<String, dynamic> {
  Response get response => Response(this["body"], this["statusCode"],
      headers: this["headers"],
      isRedirect: this["isRedirect"],
      persistentConnection: this["persistentConnection"],
      reasonPhrase: this["reasonPhrase"]);
}
