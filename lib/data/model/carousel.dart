
class Carousel {
  final String discountValue, title, description;

  Carousel({
    required this.discountValue,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<Carousel> carouselData = [
  Carousel(
    discountValue: '40',
    title: "Today's Special",
    description: "get a discount for every course order! Only valid for today!",
  ),
  Carousel(
    discountValue: '65',
    title: "Top Offer",
    description: "get a discount for every order! Only valid for today!",
  ),
  Carousel(
    discountValue: '65',
    title: "Top Offer",
    description: "get a discount for every order! Only valid for today!",
  ),
  Carousel(
    discountValue: '70',
    title: "Hot Offer",
    description: "get a discount for every order! Only valid for today!",
  ),
  Carousel(
    discountValue: '35',
    title: "Offer of the year",
    description: "get a discount for every order! Only valid for today!",
  ),
  Carousel(
    discountValue: '65',
    title: "Top Offer",
    description: "get a discount for every order! Only valid for today!",
  ),

];