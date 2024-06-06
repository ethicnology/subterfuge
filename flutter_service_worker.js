'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d57e94a71bda8af509debec0690868d1",
"version.json": "4762487be76203753340ed4f631fccb1",
"index.html": "74f275b2331b2e4974238b8779001f16",
"/": "74f275b2331b2e4974238b8779001f16",
"main.dart.js": "5d9005133ef4c0402112a732008f2cdb",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "dbef1704b29a1620e7ea103c3cbce23b",
"icons/Icon-192.png": "89c4158402bd478f25acbb8e24b417b9",
"icons/Icon-maskable-192.png": "89c4158402bd478f25acbb8e24b417b9",
"icons/Icon-maskable-512.png": "34f46d18e9272974d4072919727e9012",
"icons/Icon-512.png": "34f46d18e9272974d4072919727e9012",
"manifest.json": "dc46a434b8896666063464fa957811c9",
".git/config": "38881ccff4dc4e249623736f3cd97a15",
".git/objects/61/795a1d844205dab798116b159e1e85303d28aa": "30bac9eb53e773865fdb2d02e790da18",
".git/objects/3e/bd4069d7e3a5ea239562ce6ee3efabe3c171ae": "1f796961311dadcc279efb23287fd67c",
".git/objects/68/7317a86634c051b85bc783991f378a155867a4": "40a89625b727e2de3efee0d395cb86ad",
".git/objects/9b/d083112d5b80dc942db4868bc52b16fe10d22c": "69efcd9bb932936cb406fd801ecf7c6d",
".git/objects/32/6fd317dd9b70779ea2f077a9361dc5f84b4ecb": "e532bfae2bb3898b2a3db4ed4e1f16a0",
".git/objects/3d/91aa0a1ad675c7aa2c588c4db966b148569a7d": "1a422f9e8a8cbaacb45e1e7c5269e02e",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/0b/d184764df9df6c713011c8e230367c27af37ac": "db810accddb1bce0bff7a42f7615fa17",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b4/b458ffdaa2d32b338527b2704a926002a4800a": "ca59ed4cfec7599f37647999f6a326b2",
".git/objects/b4/a3ecb9428e2a4b8aff40c099e1c27d64a928f0": "6e4bc29289eb6be950713f1b329eaf0d",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/f3/d19c3edac39532fa0df383a52352d9dea12bef": "056e41ce02e18f06fcc15fbe17d09595",
".git/objects/c7/a24677d9bcba8ea0e811f91567bfa04a08b355": "8f33a6c4061d706d519819ee982da2c0",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/fe/0f4147161d5cfd2bd90bdb1cfc0cf733a40b12": "10723e5aad6617a08b6210f08d1e2cdd",
".git/objects/ed/16394601480c6a69230b2ba4cc9db9cc9534a2": "16ebd0e8384528ccd9a4c3ec4c89ade8",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/86/c57b852673a63af1e25f84319ed65515fe3ac5": "34584aa28b2ac2df8c1be579a7628aa7",
".git/objects/2a/fff33d989aeec60793797d04daac7c6c0978fc": "4c6cca1c169eb498ad2e4c715ffe1fd5",
".git/objects/6b/35879e48d55ed0f3a655e280deeed030524cfe": "2743c078fec140934905f1f6be2259e1",
".git/objects/09/4bb6ae24f0cd847d40cb4cc4a2434f2ec9b83b": "b9e6d850322c11db635bcf0a45b762ff",
".git/objects/96/3cffa1ebcb550dacc81116ad6bbf16c5743ff4": "a50b383cdc0e738e821f10ab572723ee",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/6c/fe70da2ace8e63b02013ebda1a424658d3fef6": "23e0e74efc223a6750d095f660c64db7",
".git/objects/0a/d5ffc92ee7b74e1fa5476797461b841ab7fdbd": "1e83ab9c85da7bb6008e8f4b91d87956",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/ba/6356b15a28b6da527f5533c7d038f63091b944": "cc965e11714ad59d87e856df71da9e21",
".git/objects/b1/6b6a097cee99bcc0c2676bc0c17d435330a680": "9afbe08d18fd9d645cdc4c9057b33706",
".git/objects/db/cc4698f9ce6fccee482cc7101f24a847d7eecc": "e1c3e573bfd108c22fee64b10f8a1191",
".git/objects/db/97f0e2ef33abbf54c69794d36c3fa8ae933aa2": "d34cf87edd8ae4a441b96b0cd01a88e9",
".git/objects/a8/778fba19a21ed2fe5989b945acfee13351d55c": "91413d98d2d282d3ba66189bc88d4869",
".git/objects/b0/80c011aca9db7953b5fa5a8b399d3adabc8b28": "b878245231338402c4b9a13f3dad413a",
".git/objects/ef/b6d1bcc502310c0581d9737eb69827a39de888": "c7263043af43165a45633f8cd4ad0dc4",
".git/objects/c4/92dcb23a06ffdf40843d3cb19f4d1722f28001": "1dbad06da2989e5aa91f546f0b79f0f2",
".git/objects/cd/530cc66627f4b700b767ddc8a5f00752d0398a": "e4cdc2101d5dc7699c12ac5541f25482",
".git/objects/e6/a33c2b03a103d76ae39201c3ca0d2143410f71": "d0b565f21f8455924ca7afed87dad69b",
".git/objects/f9/e1c5cfd60cdf4df49700e5639ea38f85356e93": "5d818ac2ed7c2a72b01105d7c9371ad9",
".git/objects/c2/f1974e25d27cee54381eab15f70dcb2e2c4859": "d27dcf16cb1ce7dc4795eb2946750bb3",
".git/objects/e0/df0a36d5883b357a64c0fe9fbff25cc640e3a1": "6a269e100926470f7f05079c9b1c1b6d",
".git/objects/e0/653cfc4bf151ac572a3e71af2aca239af5f0fe": "a9fcb9fc2d10b76e7a660406e067ba0a",
".git/objects/41/4ea2ba2200882b9c8e15081a2304e9abf6566a": "c47a7cbaa019acb622f882e0c46e12f2",
".git/objects/1b/be32acfdfb983ffad863d1fe60d6a78b58e703": "7cee63aa26c0065fd79502cec483b432",
".git/objects/1e/c3ebdf6a87db853ced3fe7e45d01e582027542": "405dff5a542e5367f986ef0a71ce1512",
".git/objects/4f/f553ed48d17e52811c337c3db2198f3b95f5d9": "10ee9a9267cbb5d1d5ba205ab3e90bf5",
".git/objects/12/862d379579b4bcf49686c07812aede4a2fd1f1": "ee8bd14834d761e54336469b592477e2",
".git/objects/1d/b02a3c5903b54c3929a40dfbbdfab52ac5d0bf": "4bd1eed009144962f45c4bb49c06af22",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/71/1f3fb43ccb8e726f768daffc0d97945ec67a31": "701deea13d97b3592b07ba8e1aa55a1f",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/49/c4e1faf370a81f2027019f01db1337eb674a31": "1444f63a197a1608f3d40689d364eb8d",
".git/objects/40/49be7678c8cfbda58edbde514d5301765fb64d": "668707704a58979e37debb6f98324966",
".git/objects/14/0323e00ca0ee54b585dfeaa00acdcee78c7340": "08ad21253076c6f3233aef512bcbadb2",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "cda18f62936bb4feeabae792c38d98b4",
".git/logs/refs/heads/master": "cda18f62936bb4feeabae792c38d98b4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/master": "77e75af264920ebdc21ddbb3e1740b47",
".git/index": "8ca108952112792c39e223fa53520424",
".git/COMMIT_EDITMSG": "45c9eb7fa6e6a781268f8a3b8d62d8b9",
"assets/AssetManifest.json": "11e67c87644ac52898a4f9d471682747",
"assets/NOTICES": "459e4a9c129715cd79a9088a315f5075",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "0a4a89a6d7ae34ddc4c074b0e1a5fdf2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "c9adda9aa1677400d0f021116ec13c89",
"assets/fonts/MaterialIcons-Regular.otf": "06ecf876db1003ff00bbc3081563a47c",
"assets/assets/taupe.png": "25c6370d118bed2d0730c900240f56cf",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
