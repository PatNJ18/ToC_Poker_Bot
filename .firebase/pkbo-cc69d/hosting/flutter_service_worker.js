'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "abe7f921ec4d61bdd2bdc9a5fce58cda",
"index.html": "ca057389b740e4def6aebf5d2697cc53",
"/": "ca057389b740e4def6aebf5d2697cc53",
"main.dart.js": "b655f95d9210b048e7dc7ed751239ce1",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d46a036aa5b832b9b9d9b3587c132b16",
"assets/AssetManifest.json": "59d74eb2cdce5c5cb9098ca00c07fb8d",
"assets/NOTICES": "6e4279b372f6faeb68c2c65ccfe8fb47",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "ff4f5113bb73d468e53793d12291c13e",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/assets/images/C8.png": "432bb0ca3935f003c4927e3342d6fc61",
"assets/assets/images/C9.png": "75a6be53f36dfe04073e697d032d40c9",
"assets/assets/images/CK.png": "d5d3e47e7b9ea55b9756cad61ea8c0bf",
"assets/assets/images/CJ.png": "fa74c60da032038dc3524baf301afa6e",
"assets/assets/images/S6.png": "9dab424592000b2edf662c2bfe21d146",
"assets/assets/images/HJ.png": "a361dfbeefa6744a488b049e7d3e4b76",
"assets/assets/images/HK.png": "feb9c6ee7f6e98b6c97479c683c1d675",
"assets/assets/images/S7.png": "a5fd38f870009a1099ed9320b807faac",
"assets/assets/images/SA.png": "5188133ad4427d4e4c2a6198f95561d0",
"assets/assets/images/ST.png": "1558c81254e6541d3cf74cec071df395",
"assets/assets/images/S5.png": "cba98b657c2f3c63f615bd568f6c062e",
"assets/assets/images/DJ.png": "92e35c111caf327a5e1a75b7b5367f61",
"assets/assets/images/DK.png": "b2ae41b4503a9ca5daa1b4e42b9be177",
"assets/assets/images/S4.png": "07a123258632171afaf98d20e593542f",
"assets/assets/images/SQ.png": "5a2f3ccbe067346e32682ceeb4e12e2c",
"assets/assets/images/D9.png": "a1ce33d70013681b227feb8ee882c858",
"assets/assets/images/D8.png": "52040fac857f3e899e6abb10bde544f4",
"assets/assets/images/S3.png": "6143c0834971a27bcd0ec00a9a27fe52",
"assets/assets/images/H9.png": "e9abb31d85911fab49aebc5b7343e9c3",
"assets/assets/images/H8.png": "e2aa8c7ae2dc6c259b372c66c35d341a",
"assets/assets/images/S2.png": "c754c52e8ece30338e4c7a3978e02dee",
"assets/assets/images/HT.png": "b74320e2e2e7796677ac8022064b5358",
"assets/assets/images/H5.png": "7e4c2d08528367b4af79369847d4ef36",
"assets/assets/images/D6.png": "edcc723aa4e27e67c2ce13b59d765aa5",
"assets/assets/images/D7.png": "2dfb7a283c82265370957b8ad32c322d",
"assets/assets/images/DA.png": "50abc74a159390b6c8842a29d8d16054",
"assets/assets/images/H4.png": "4b6a3b8dab61f746abd0802c3c7f0fb6",
"assets/assets/images/SJ.png": "2a5e66d37d9fa31b7767b842f2f07ed3",
"assets/assets/images/H6.png": "f25c314f161eee9e4930121cbf3a7f0d",
"assets/assets/images/D5.png": "b544862341580f5e509416c414dca017",
"assets/assets/images/DT.png": "fbfbdcbb30113f7463a06ea2a9d41753",
"assets/assets/images/D4.png": "be16a4d0597da55a88734bc663089126",
"assets/assets/images/H7.png": "e5557acb5b56230d4c5b16cdad68637b",
"assets/assets/images/HA.png": "e0d6581ce011a1e3b6929ca7237f76de",
"assets/assets/images/SK.png": "25bfb15cb15246c738a5a504beaa5fc3",
"assets/assets/images/S9.png": "c2cdc9c1ad532bcd40a69f5acc9c0666",
"assets/assets/images/H3.png": "f6c75fa093cd6ac5aea80f6874781c27",
"assets/assets/images/DQ.png": "159f2136ed4089c2e95b543a72c01d6d",
"assets/assets/images/H2.png": "fe2eed8d05fbf761f3b620c49b5695cc",
"assets/assets/images/S8.png": "a231c0c2a72ea7b4566412780729cd9d",
"assets/assets/images/HQ.png": "c2d9ae0cdce63609f805c0c35b9337a1",
"assets/assets/images/D3.png": "41632775c4731bf5476301f5d0fcfb61",
"assets/assets/images/D2.png": "c7fefb8c4a85fae6e44d9dbc6523f34d",
"assets/assets/images/BC.png": "23cd6a49edb2f08b1e3e4e61eb233f17",
"assets/assets/images/CQ.png": "75e2356e5b412ebcdbe643c01ae23ec6",
"assets/assets/images/C2.png": "9a66f40b6e5a000c62ecf17b840716d8",
"assets/assets/images/C3.png": "0ddeb3cdbac18895cdf258b7f1098a24",
"assets/assets/images/C7.png": "155525dee77b98d3b419f5c3f6ac7461",
"assets/assets/images/CA.png": "da68f7d9263af44c2f1bcf7831dd785d",
"assets/assets/images/C6.png": "061491b312d17f5ce7baf190e9c6ebcb",
"assets/assets/images/C4.png": "5331673938e16b304018ac7ab203d794",
"assets/assets/images/CT.png": "7533ca07cf5d5427c801ff1935e24e88",
"assets/assets/images/C5.png": "ce0c76b1f9856e16b32dc947c7ead30c",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
