module LogoSvg exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)


logo =
  svg
    [ 
     class "logo",
     width "96",
     height "19",
     viewBox "0 0 96 19" ,
     fill "none"
    ]
    [ Svg.path
     [
      d "M39.082 10.188L36.968 18H34.322L33.09 12.932L31.816 18H29.184L27.056 10.188H29.45L30.556 15.774L31.872 10.188H34.406L35.736 15.746L36.828 10.188H39.082ZM41.199 9.376C40.779 9.376 40.4336 9.25467 40.163 9.012C39.9016 8.76 39.771 8.452 39.771 8.088C39.771 7.71467 39.9016 7.40667 40.163 7.164C40.4336 6.912 40.779 6.786 41.199 6.786C41.6096 6.786 41.9456 6.912 42.207 7.164C42.4776 7.40667 42.613 7.71467 42.613 8.088C42.613 8.452 42.4776 8.76 42.207 9.012C41.9456 9.25467 41.6096 9.376 41.199 9.376ZM42.389 10.188V18H39.995V10.188H42.389ZM48.8839 10.104C49.7985 10.104 50.5265 10.4027 51.0679 11C51.6185 11.588 51.8939 12.4 51.8939 13.436V18H49.5139V13.758C49.5139 13.2353 49.3785 12.8293 49.1079 12.54C48.8372 12.2507 48.4732 12.106 48.0159 12.106C47.5585 12.106 47.1945 12.2507 46.9239 12.54C46.6532 12.8293 46.5179 13.2353 46.5179 13.758V18H44.1239V10.188H46.5179V11.224C46.7605 10.8787 47.0872 10.608 47.4979 10.412C47.9085 10.2067 48.3705 10.104 48.8839 10.104ZM53.0815 14.08C53.0815 13.2773 53.2308 12.5727 53.5295 11.966C53.8375 11.3593 54.2528 10.8927 54.7755 10.566C55.2981 10.2393 55.8815 10.076 56.5255 10.076C57.0388 10.076 57.5055 10.1833 57.9255 10.398C58.3548 10.6127 58.6908 10.902 58.9335 11.266V7.64H61.3275V18H58.9335V16.88C58.7095 17.2533 58.3875 17.552 57.9675 17.776C57.5568 18 57.0761 18.112 56.5255 18.112C55.8815 18.112 55.2981 17.9487 54.7755 17.622C54.2528 17.286 53.8375 16.8147 53.5295 16.208C53.2308 15.592 53.0815 14.8827 53.0815 14.08ZM58.9335 14.094C58.9335 13.4967 58.7655 13.0253 58.4295 12.68C58.1028 12.3347 57.7015 12.162 57.2255 12.162C56.7495 12.162 56.3435 12.3347 56.0075 12.68C55.6808 13.016 55.5175 13.4827 55.5175 14.08C55.5175 14.6773 55.6808 15.1533 56.0075 15.508C56.3435 15.8533 56.7495 16.026 57.2255 16.026C57.7015 16.026 58.1028 15.8533 58.4295 15.508C58.7655 15.1627 58.9335 14.6913 58.9335 14.094ZM65.4534 11.294C65.6774 10.93 65.9994 10.636 66.4194 10.412C66.8394 10.188 67.3201 10.076 67.8614 10.076C68.5054 10.076 69.0887 10.2393 69.6114 10.566C70.1341 10.8927 70.5447 11.3593 70.8434 11.966C71.1514 12.5727 71.3054 13.2773 71.3054 14.08C71.3054 14.8827 71.1514 15.592 70.8434 16.208C70.5447 16.8147 70.1341 17.286 69.6114 17.622C69.0887 17.9487 68.5054 18.112 67.8614 18.112C67.3107 18.112 66.8301 18.0047 66.4194 17.79C66.0087 17.566 65.6867 17.272 65.4534 16.908V18H63.0594V7.64H65.4534V11.294ZM68.8694 14.08C68.8694 13.4827 68.7014 13.016 68.3654 12.68C68.0387 12.3347 67.6327 12.162 67.1474 12.162C66.6714 12.162 66.2654 12.3347 65.9294 12.68C65.6027 13.0253 65.4394 13.4967 65.4394 14.094C65.4394 14.6913 65.6027 15.1627 65.9294 15.508C66.2654 15.8533 66.6714 16.026 67.1474 16.026C67.6234 16.026 68.0294 15.8533 68.3654 15.508C68.7014 15.1533 68.8694 14.6773 68.8694 14.08ZM77.3214 10.104C78.236 10.104 78.964 10.4027 79.5054 11C80.056 11.588 80.3314 12.4 80.3314 13.436V18H77.9514V13.758C77.9514 13.2353 77.816 12.8293 77.5454 12.54C77.2747 12.2507 76.9107 12.106 76.4534 12.106C75.996 12.106 75.632 12.2507 75.3614 12.54C75.0907 12.8293 74.9554 13.2353 74.9554 13.758V18H72.5614V10.188H74.9554V11.224C75.198 10.8787 75.5247 10.608 75.9354 10.412C76.346 10.2067 76.808 10.104 77.3214 10.104ZM84.389 11.294C84.613 10.93 84.935 10.636 85.355 10.412C85.775 10.188 86.2556 10.076 86.797 10.076C87.441 10.076 88.0243 10.2393 88.547 10.566C89.0696 10.8927 89.4803 11.3593 89.779 11.966C90.087 12.5727 90.241 13.2773 90.241 14.08C90.241 14.8827 90.087 15.592 89.779 16.208C89.4803 16.8147 89.0696 17.286 88.547 17.622C88.0243 17.9487 87.441 18.112 86.797 18.112C86.2463 18.112 85.7656 18.0047 85.355 17.79C84.9443 17.566 84.6223 17.272 84.389 16.908V18H81.995V7.64H84.389V11.294ZM87.805 14.08C87.805 13.4827 87.637 13.016 87.301 12.68C86.9743 12.3347 86.5683 12.162 86.083 12.162C85.607 12.162 85.201 12.3347 84.865 12.68C84.5383 13.0253 84.375 13.4967 84.375 14.094C84.375 14.6913 84.5383 15.1627 84.865 15.508C85.201 15.8533 85.607 16.026 86.083 16.026C86.559 16.026 86.965 15.8533 87.301 15.508C87.637 15.1533 87.805 14.6773 87.805 14.08Z",
      fill "#EB5757"
      ] 
      []
    ,
    Svg.path [
     d "M8.22724 4.5C9.38194 2.5 12.2687 2.5 13.4234 4.5L19.0526 14.25C20.2073 16.25 18.7639 18.75 16.4545 18.75H5.19615C2.88675 18.75 1.44338 16.25 2.59808 14.25L8.22724 4.5Z",
     fill "#EB5757"
     ] []
    ]