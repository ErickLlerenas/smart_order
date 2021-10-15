const darkPrice = 10;
const electroPrice = 0;
const firePrice = 0;
const icePrice = 12;
const lightPrice = 9;
const parasitePrice = 11.5;
const metalPrice = 0;
const waterPrice = 11.25;
const windPrice = 13.5;

let plantCounter = 0;
let buyButtonCounter = 0;

const dark = "https://marketplace.plantvsundead.com/_nuxt/img/dark.d661f0f.svg";
const electro =
  "https://marketplace.plantvsundead.com/_nuxt/img/electric.0da5192.svg";
const fire = "https://marketplace.plantvsundead.com/_nuxt/img/fire.c6c0671.svg";
const ice = "https://marketplace.plantvsundead.com/_nuxt/img/ice.e1484b7.svg";
const light =
  "https://marketplace.plantvsundead.com/_nuxt/img/light.b026314.svg";
const parasite =
  "https://marketplace.plantvsundead.com/_nuxt/img/para.1836eab.svg";
const metal =
  "https://marketplace.plantvsundead.com/_nuxt/img/void.5cc4954.svg";
const water =
  "https://marketplace.plantvsundead.com/_nuxt/img/water.a8971f4.svg";
const wind = "https://marketplace.plantvsundead.com/_nuxt/img/wind.8751797.svg";

const checkPlantsPrices = () => {
  const plants = document.getElementsByClassName("hover:tw-bg-gray-800");
  for (let i = 0; i < plants.length; i++) {
    const image = plants[i].getElementsByTagName("img")[1];
    switch (image.src) {
      
      case dark:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= darkPrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;
        }
      case electro:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= electroPrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;
        }
      case fire:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);
          console.log(price)

          if (price <= firePrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;

        }
      case ice:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= icePrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;
        }
      case light:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= lightPrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;
        }
      case parasite:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= parasitePrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;
        }
      case metal:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);
          console.log(price);
          if (price <= metalPrice) {
            console.log(price,metalPrice);
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
            break;
          }
        }
      case water:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= waterPrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
          }
          break;

        }
      case wind:
        {
          const price = parseFloat(plants[i].getElementsByTagName("p")[2].innerText);

          if (price <= windPrice) {
            plants[i].getElementsByTagName("p")[2].click();
            if (plantCounter === 0) {
              pressBuyNowButton();
              clearInterval(interval);
            }
            plantCounter++;
            return;
            
          }
          break;
        }
      default:
        break;
    }
  }
  return;
};

const interval = setInterval(() => {
  setHackToUncommonElement();
}, 150);

const setHackToUncommonElement = () => {
  const elements = document.getElementsByClassName(
    "item tw-text-center tw-cursor-pointer tw-relative"
  );
  const uncommon = elements[12];
  uncommon.addEventListener("click",checkPlantsPrices);
  uncommon.click();
  return;
};

const pressBuyNowButton = () => {
  const button = document.getElementsByClassName(
    "btn__sell v-btn v-btn--is-elevated v-btn--has-bg theme--light v-size--default"
  )[0];

  const buyInterval = setInterval(() => {
    if (button) {
      clearInterval(buyInterval);
      if (buyButtonCounter === 0) {
        button.click();
      }
      buyButtonCounter++;
      return;
    } else {
      pressBuyNowButton();
      clearInterval(buyInterval);
      return;
    }
  }, 10);
};
