'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/refs/heads/main": "61836db96e440d17a778fa445b725f57",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/refs/heads/main": "d23b858387bb8c15f599240dbdce2a12",
".git/logs/HEAD": "c18d2c6298a1a24dd5fa8b5a071ae176",
".git/index": "877ed08170ed4dbc1c340c8fc02a7f49",
".git/objects/94/b988bd342bb0473e542602b27c486dfa8bece8": "1b31cc32bfa6ed0db2355f4224693b67",
".git/objects/df/f3ed85f469d578c20bf8bd965b4db2bf582b94": "0696337710fc49ecce35be0caf1b3ee3",
".git/objects/fd/a42e7fd6669443abf0ab11cf4aa3b640a848ab": "d814dee8bc1150fa3ef76e2b43c856dd",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/ad/68554bff6c4c087b53a3a5b7e5b5c8c6c179be": "e2279a4e041c2f7dd6c6fc5663920073",
".git/objects/76/82cb8ec7da2e9be7d90667b4d15450d3d6e2b7": "b1541efc3699b9a41328418e5d0872e3",
".git/objects/ae/52b15c968b3f086dc166b1d40e2578db089492": "e1c6600a86bb3520dab5d9bbe374d02d",
".git/objects/aa/16af1992a26e640ccdf6e00b7d8958ca4a5f4b": "fabc45cdfad3afe9a1650a8d27720f7c",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/37/245d1f4972ebe063b4df810d311cd4dd9d05c8": "1608f8f0c854c67ade54da857c947115",
".git/objects/62/770fd40311510156dbbd13a3a26b9a521672e5": "ffeb5a4e9581d9d2b6fd496ed18aa39d",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/58/493712a68b4fa04a38ba3ef8f21f4fcf9cf107": "4d7e6b3cb9ae3331f14f9505301c03b4",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/f7/5b3c107fd052b45b189de9f79884cb924d4414": "77bf15397106d997a7be682c6a42fef7",
".git/objects/64/85633e8b3bdd49caf97c5d405ce9c770bb2a6c": "b0aa77681b522acc7e17542db97166cd",
".git/objects/57/5b58e52826a5e7aca845e281e1ded9bc45e756": "9fac0e64175411552ab23f4f712fb7d9",
".git/objects/6e/b781926c4291dc3ea7edaae4abd060175d3307": "3786f635464e0c1e16f782ed2119f9b0",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a2/a16109e7ae1a2501e6b3eaad1d7c4132339e21": "7834a8c300e9ee2d99487dd15a10f3f3",
".git/objects/0c/01b15639eb6834cc1379ec326ece60a9843d22": "772ad554ab66fea5c49552007563e3dd",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/84/413d466bc6a87fd1821297cd2a6e6e9c461456": "545dc35a9a702dc1d98b96865c568fb5",
".git/objects/a1/658eb0901e65383f1f118239b86f7ee1a3b62d": "2ac8603b0740e5e16f2f8f0c5714b5dc",
".git/objects/a1/1b72702024574bdfac9b6511f5bb954f3203f7": "aa7cecfc39ba01e0e4b6b5ce95626c82",
".git/objects/a4/6895746cb63bf098f031f7707e270fb955d0ae": "8a0b3ed0cdb130450df9028f647021be",
".git/objects/25/fdc4af35fe13e158f5db3050040db5d2c16792": "bdb52e24cef6cc6adcb263460f06b05e",
".git/objects/69/f285ef90c703f82b120899a3dae4749ba25adf": "8021edf6f928873a0e179dd94be3aa2a",
".git/objects/db/27ba856e1d82de09983dc1fac4a8511e11b45b": "967e3b14a265a8f892c15071477710a4",
".git/objects/dc/ccc71b9480739aff01eab09f6712cbb628fd05": "559d20f0f9afadf0d2d7caa40b233e9a",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/96/a6fef4ce7844a3a2999a3395f9de2a80dd7424": "6a10f312e5538c71a7daafd27ac061ca",
".git/objects/1f/5f3967d28aa2ce262d94e6f7edc3c51861240b": "f5c2e97e4866a56f78d8df2cec0c6823",
".git/objects/a9/fad1eebc52029f861a2dd220d586d79cc7fa09": "38888911fbae823246988dd6f41c259e",
".git/objects/ed/4aac9d7df3be81f7460febda1605ced87d9733": "37f9f9bc90b73a610d8b39361e3a3057",
".git/objects/55/581e7760b3be322e0475095b88eb41bcb86d34": "ec9264e612fca2fe0038dce4030df97f",
".git/objects/de/9f6d5d3891f1c64dce3bd2076509501835a91c": "6aeafbcab1da10c6879511f356e506d3",
".git/objects/dd/f95ac4b49eb5afad8f1c1610637d4de3500467": "323f2c68bc9339f3a1a9c796301416d9",
".git/objects/60/1eb782ec41008ccc7e1d767b66b14cdf72276c": "fdd02060cb48e17ffae2f5e49cc32fc3",
".git/objects/35/776949a2f755010e25d772d706fd28f62b0a81": "59c7379e69afb8bf8cefa3671785ee66",
".git/objects/35/b339bd7aec3a9d69fda0dafc2a71ec8e0cb709": "b1e7cc77764422fff16955f04aba099b",
".git/objects/c5/96d753b78e4e67f33e29ecdadb70c2b8111ae5": "97bd85ea6be1b4e587442dc6547bc2b7",
".git/objects/c5/232232b71986ec109a2996748dcca0a00612ce": "3597bf9b7cdb100d6d2d6bdcf3908a62",
".git/objects/9b/d90a16f8ace441db717e2c0a91a2f2bc112eb8": "2d8e86001581d594cbdce9892d87dd66",
".git/objects/5a/b84321e042a9c5a4fc89c992f86cd83b3588a9": "749d66a9a6dbd7a18a34b0bb8323e983",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/5f/e1cf0ee3cfcd9663e15c43c668bcc716b40ef6": "9c5a2913c016549ceaf20f377a163b84",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/2e/90b005d2ba0256e166af7ae80c5b63821f8885": "ced20d2c4518baded26e4856e88f3cc7",
".git/objects/31/bc745b0871f6b06ddb91cc637091f7202b9d30": "4fd1d612e7d6b1c2f8b802efd8713f66",
".git/objects/30/c2fa563513913ea4606f8df04c221b49f2e7be": "6b4cc7d21cce9c7938f36187088f3910",
".git/objects/30/655b398402cd5f1341323b141c4ee0f434682e": "ce61ce742c3be3c45e542cccbd3061c6",
".git/objects/1b/6515b8e2cc8a19a41ab6abaf4bd0a16f7f3cf9": "4e19d6115591d600283def0dd9582e06",
".git/objects/0e/ed98db6878fce875936d5f6a1d83e91d78021e": "1884b61bd4545e33a56914f67a4047d9",
".git/objects/e6/93564b16188c26fe146bd764f1b0e2216df732": "e82622a56814be63c1b1c4847a0467a7",
".git/objects/1a/968f491f08a06ef033fdf95c180f1cbd3fb3c0": "21c87233490fa1727da5021a2703ff79",
".git/objects/1a/6ba93ed518342d06f60b4ee8fa90d3efe8d5f9": "833b1208a364ff2739220f246210f460",
".git/objects/ee/5837bc396e9de374e4ae577d5b50417e0930c1": "f64c35abba1f279c565b1b2254c6ff5b",
".git/objects/6c/47356f610d8d7ccd95f85c71e155392a89bd5c": "eca5feb64dcf2fbb10e9bd0f5dcb81cf",
".git/objects/6c/576537d96a245698ab1fd9ac369fcebc852ca0": "53cc353eaf27bdfc95d1a29713ac3008",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/6f/7c2c12d6516d2c061d658e076e1ee4c5652d2b": "1f55f76ccf70824070e73e003ca93fdb",
".git/objects/4c/e1e34a3674d676b99fb719b3851e09fde10f57": "575973a7e505c81047c4c511e099c2fe",
".git/objects/bd/fa316bc8232b77a6f6f77679ccc596938566d4": "23ecd8bac378822bddcf29d8054861c1",
".git/COMMIT_EDITMSG": "45c9eb7fa6e6a781268f8a3b8d62d8b9",
".git/config": "5b603c2c0801a9ded3b79159fc38b404",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"flutter_bootstrap.js": "f7759f923080cf1cfd47add743005674",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"index.html": "be85c6fd28a5f388a00252f1e53113d6",
"/": "be85c6fd28a5f388a00252f1e53113d6",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"icons/Icon-maskable-512.png": "93420b8630c182750166b98d726a1157",
"icons/Icon-512.png": "93420b8630c182750166b98d726a1157",
"icons/Icon-maskable-192.png": "b3fbbe64c58a0d9725dce57e3025e8ae",
"icons/Icon-192.png": "b3fbbe64c58a0d9725dce57e3025e8ae",
"manifest.json": "0dcf12adc061b3003a11d688b0ae8364",
"assets/NOTICES": "2e251ed2cf9d9ae3739cb6ab1e65c4e1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin.json": "856c09d28c14a2dbe28c9d6c6be3af5d",
"assets/assets/logo.png": "147f7a5f50a6b50dfbcc826419a92e82",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "3bce676b48d2018c9728a4a35044ba0a",
"assets/AssetManifest.bin": "4bb2d72aff6c08d18293a61a80f6821c",
"main.dart.js": "d73737829b9ad84a099465d349f622bc",
"favicon.png": "e6122ccf73444ab4f20b07e1e67a24ec",
"version.json": "bfe8469c512a0961f1d1ff815d00e0ad"};
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
