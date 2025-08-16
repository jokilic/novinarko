'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "82d26ebe6906f85e15bcd9175f9045f5",
"version.json": "41d5c057162aea3fdab5f559d09c659c",
"splash/img/light-background.png": "e02878f73946334e904cbf9e9c9c33f6",
"index.html": "a40212d533b9ee0aa65741e407c45bed",
"/": "a40212d533b9ee0aa65741e407c45bed",
"main.dart.js": "b78026af0db2c463c429bb49f8e023c9",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "87abd26238b059ad6445a8294dc2424c",
"main.dart.mjs": "76b9c44e599541dc5007d06fb3afe99a",
"icons/Icon-192.png": "25465e88e0ee9271995a0f7622206939",
"icons/Icon-maskable-192.png": "25465e88e0ee9271995a0f7622206939",
"icons/Icon-maskable-512.png": "743c26cced6bdd77c5c4c6b4e2422747",
"icons/Icon-512.png": "743c26cced6bdd77c5c4c6b4e2422747",
"manifest.json": "5e5e01a5a3032983205f34d557b74166",
"main.dart.wasm": "3416a90ebd96e70632d9abe602d71ccd",
"assets/AssetManifest.json": "1ce19250f79872765909f9ca33b7cfee",
"assets/NOTICES": "52e624750a1e2c7de8a98373fa8bfd8b",
"assets/FontManifest.json": "e4b8031eeaf68f4ddda5eb266dba829b",
"assets/AssetManifest.bin.json": "ccbba245445ab68d0ea29bcc7683ef7b",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1e5436734da9043d3341f12a4fd9272a",
"assets/fonts/MaterialIcons-Regular.otf": "deba07280281a94d6834e5fa05071d0e",
"assets/assets/icon.png": "8cbbf2c19d8d29bebdaafcc6af3d0f4a",
"assets/assets/splash_icon.png": "a4ee37fc9d6dfefdf7c76134f0646c0a",
"assets/assets/splash.png": "e02878f73946334e904cbf9e9c9c33f6",
"assets/assets/audio/welcome_to_novinarko.mp3": "1f171e0da04231ca44d879c711030fd0",
"assets/assets/audio/boom.wav": "c201b23f82c5b1e0ed58de6c44ee6e8d",
"assets/assets/icons/info.png": "d82e29a693cb760e0149906419f23975",
"assets/assets/icons/news.png": "d1d9335c1e1fb732d5777cf8e1dbb1b1",
"assets/assets/icons/check.png": "5ea11e11679eb2df816e9aa46d564f3e",
"assets/assets/icons/settings.png": "df3382b5c4b37521c5be749eb993ae44",
"assets/assets/icons/all.png": "ea30c21ca6b4ef1f55a7dddbd4d52143",
"assets/assets/icons/no_news.png": "502983d24a14b738a534ce531db6a97e",
"assets/assets/icons/yes_news.png": "dc0dedf39c220a841254f4c8129378b0",
"assets/assets/icons/browser_back.png": "262d1ecb6e86eed651f9e58957826999",
"assets/assets/icons/search.png": "9cc0e020dcf155dd27d0f13b56e824a1",
"assets/assets/icons/error_search.png": "74f49c934f2e1b76f6031fdb3a6ef181",
"assets/assets/icons/custom_search.png": "6c6bdeafc1a9d84e204ade3f9c2fa94a",
"assets/assets/icons/error_news.png": "3768df6ffd6d6d0d0d87aaa16377a7d8",
"assets/assets/icons/share.png": "908835845e4699124d95ab45f9456627",
"assets/assets/icons/delete.png": "4cd3280d95085dbac686410a83208339",
"assets/assets/icons/no_search.png": "36354a7cd893343725d5a33ef0e83714",
"assets/assets/icons/back.png": "cfbc6c305c365a84b6aa38fb09de419a",
"assets/assets/icons/refresh.png": "60dde7d4abd257040cb01f6399d8eebf",
"assets/assets/icons/close.png": "6fb374412a957159df96a8f7057c6896",
"assets/assets/fonts/Merriweather/Merriweather-Bold.ttf": "a16014ad21cef5e9407156c3d6cc3bd8",
"assets/assets/fonts/Nunito/Nunito-Medium.ttf": "5f504c0f28f0bbbb9ea94cd0b23aef34",
"assets/assets/fonts/Nunito/Nunito-Bold.ttf": "a69d02bf1d69ee833dfefdb5d21eec9b",
"assets/assets/translations/en.json": "6132d6c93685fb8b6d06b30fbe56e488",
"assets/assets/translations/hr.json": "f2d41216dbf1d0c12612bf1442e51e3d",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
