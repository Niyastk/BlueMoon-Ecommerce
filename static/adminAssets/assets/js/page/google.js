
function myMap() {

    let map;

    
      map = new google.maps.Map(document.getElementById("googleMap"), {
        center: new google.maps.LatLng(-33.91722, 151.23064),
        zoom: 16,
      });
      const iconBase =
        "http://pixelwibes.com/template/ebazar/html/dist/assets/images/";
      const icons = {
        emb: {
          icon: iconBase + "shop.png",
        }
      };
      const features = [
        {
          position: new google.maps.LatLng(-33.91721, 151.2263),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91539, 151.2282),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91747, 151.22912),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.9191, 151.22907),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91725, 151.23011),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91872, 151.23089),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91784, 151.23094),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91682, 151.23149),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.9179, 151.23463),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91666, 151.23468),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.916988, 151.23364),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91662347903106, 151.22879464019775),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.916365282092855, 151.22937399734496),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91665018901448, 151.2282474695587),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.919543720969806, 151.23112279762267),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91608037421864, 151.23288232673644),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91851096391805, 151.2344058214569),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91818154739766, 151.2346203981781),
          type: "emb",
        },
        {
          position: new google.maps.LatLng(-33.91727341958453, 151.23348314155578),
          type: "emb",
        },
      ];
    
      // Create markers.
      for (let i = 0; i < features.length; i++) {
        const marker = new google.maps.Marker({
          position: features[i].position,
          icon: icons[features[i].type].icon,
          map: map,
        });
      }
 

}