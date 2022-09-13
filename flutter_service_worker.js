'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "5ef8e81a3c1e95e61274a0e7108bcbc4",
"favicon.png": "dbef1704b29a1620e7ea103c3cbce23b",
"icons/Icon-192.png": "89c4158402bd478f25acbb8e24b417b9",
"icons/Icon-maskable-512.png": "34f46d18e9272974d4072919727e9012",
"icons/Icon-maskable-192.png": "89c4158402bd478f25acbb8e24b417b9",
"icons/Icon-512.png": "34f46d18e9272974d4072919727e9012",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.json": "11e67c87644ac52898a4f9d471682747",
"assets/shaders/ink_sparkle.frag": "c096fda68263a74fe7d02b19ee3d8c91",
"assets/assets/taupe.png": "25c6370d118bed2d0730c900240f56cf",
"assets/NOTICES": "470173e60f51d547f83b768c04f02f7e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "4dcf7919de050f1298bdf81f19808990",
"/": "4dcf7919de050f1298bdf81f19808990",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/index": "090c6181b4498440090d00dd815fa724",
".git/COMMIT_EDITMSG": "45c9eb7fa6e6a781268f8a3b8d62d8b9",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/config": "5b603c2c0801a9ded3b79159fc38b404",
".git/objects/b4/b458ffdaa2d32b338527b2704a926002a4800a": "ca59ed4cfec7599f37647999f6a326b2",
".git/objects/b3/00383cc1ea31fb503745d0e27035d90c214558": "ca9570a1b363aade5d0c2b9961bccd6c",
".git/objects/68/7317a86634c051b85bc783991f378a155867a4": "40a89625b727e2de3efee0d395cb86ad",
".git/objects/d2/bcf5f0787937f30878d44041275c53f1be485c": "771955305632aa96f3806dfb822bdbb6",
".git/objects/a2/413746def2aa129ad0151ff50025679d313079": "8815d459ee5bc99a16084cede86d30df",
".git/objects/de/28db843d7df6ed23b8a7526f6b6b4a83425fe7": "797e4f7b3d8dced098c51679ff33e848",
".git/objects/ba/6356b15a28b6da527f5533c7d038f63091b944": "cc965e11714ad59d87e856df71da9e21",
".git/objects/37/b521804ad5b047756fe67b3ad68eba6b813bbe": "58fa2cd8e1388160c1fd7baa5a4a6a5b",
".git/objects/6b/35879e48d55ed0f3a655e280deeed030524cfe": "2743c078fec140934905f1f6be2259e1",
".git/objects/dd/3398bfd62887187d8e0e809e0a87f7187ab2c9": "4272dff788ba5be735ae38b3f77a806d",
".git/objects/e0/933b380af19e83549ea4dff204eecdb89f833e": "1c8b82d36ea7e6e68169677aa36ed1f8",
".git/objects/41/4ea2ba2200882b9c8e15081a2304e9abf6566a": "c47a7cbaa019acb622f882e0c46e12f2",
".git/objects/ce/dee602f6ac85e9150f6f0731614890a063eeaa": "b7746c073a15590dbee6799d7a5f093e",
".git/objects/db/97f0e2ef33abbf54c69794d36c3fa8ae933aa2": "d34cf87edd8ae4a441b96b0cd01a88e9",
".git/objects/8b/176009160dbfb1b88cbe5aa530cbef91c11e6a": "8ac4b70d09c4c44d3c159c2976c7f08e",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/b5/5f66e863e3726d91f10b6cf92b0912027b2c59": "b701e491d60a34d253de3582405881e8",
".git/objects/3f/a62095c1587e91677959a92003aca98e5d16f4": "05f349c9f750598d26d726334a90c88f",
".git/objects/1d/b02a3c5903b54c3929a40dfbbdfab52ac5d0bf": "4bd1eed009144962f45c4bb49c06af22",
".git/objects/1b/be32acfdfb983ffad863d1fe60d6a78b58e703": "7cee63aa26c0065fd79502cec483b432",
".git/objects/aa/a16c8effdaf1947641ca440e827319710a73c6": "1dfb2f3f70a7a7039f3589cb507208d0",
".git/objects/cd/22076013ce8b84475eae9bb4cd6c60b5460fbe": "81c620e2d6cbe5638d6c90ee25886389",
".git/logs/HEAD": "c860afe468d87e4d4c722ca88ecc06be",
".git/logs/refs/heads/master": "c860afe468d87e4d4c722ca88ecc06be",
".git/refs/heads/master": "dd9f77881592eb827aee5b85316b5005",
"version.json": "cea70ef4df85dbee145870689c92d379",
"manifest.json": "dc46a434b8896666063464fa957811c9"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
