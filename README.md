# http_get_cache

A cache wrapper for http get requests
This helps you achieve an "offline mode" for your flutter application.

## Installation
In your pubspec.yaml add to your dependencies
```console
http_get_cache: <current_version>
```

## Usage
First, **Initialize** GetCache.
```dart
GetCache.initialize();
```
`blackList` is an optional param that lists the url paths you want to exclude in your cache
```dart
GetCach.initialize(blackList: ["/v1/current"]);
```

You can then go ahead and use this as your http getter.

```dart
Uri uri = Uri.https("url.com", query: {"name": "my_name"});
Response response = await GetCache.instance.get(uri, headers: {"token": "my_token"})
```

## What Happens
When the underlying get request fails, GetCache then returns a cached response for the corresponding request path.
