import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Butonul ramine  jos
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 70,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 12),
              Text(
                'Add To Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // IMAGINEA MARE DE SU
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 410,
                    child: Image.asset(
                      'assets/images/main_product.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Back
                  Positioned(
                    top: 18,
                    left: 18,
                    child: _CircleButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // Favorite
                  Positioned(
                    top: 18,
                    right: 18,
                    child: _CircleButton(
                      icon: Icons.favorite,
                      iconColor: const Color(0xFFFF6B6B),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),


              // INFORMAȚII PRODUS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Nume + preț
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sportwear Set',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$ 80.00',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Rating
                    Row(
                      children: [
                        ...List.generate(
                          5,
                              (index) => const Icon(
                            Icons.star,
                            color: Color(0xFF4D9B88),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '(83)',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    const Divider(),
                    const SizedBox(height: 12),

                    // =========================
                    // COLOR + SIZE
                    // =========================
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Color',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Size',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        // Culori
                        const Expanded(
                          child: Row(
                            children: [
                              _ColorCircle(
                                color: Color(0xFFEBC7AC),
                              ),
                              SizedBox(width: 12),
                              _ColorCircle(
                                color: Colors.black,
                              ),
                              SizedBox(width: 12),
                              _ColorCircle(
                                color: Color(0xFFF26363),
                              ),
                            ],
                          ),
                        ),

                        // Mărimi
                        Expanded(
                          child: Row(
                            children: [
                              const _SizeCircle(
                                text: 'S',
                              ),
                              const SizedBox(width: 10),
                              const _SizeCircle(
                                text: 'M',
                              ),
                              const SizedBox(width: 10),
                              _SizeCircle(
                                text: 'L',
                                selected: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(),

                    // =========================
                    // DESCRIPTION
                    // =========================
                    const _TitleWithArrow(
                      title: 'Description',
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Sportswear is no longer under culture, it is no '
                          'longer indie or cobbled together as it once was. '
                          'Sport is fashion today. The top is oversized in fit '
                          'and style, may need to size down.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.6,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Read more',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF4D9B88),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    const Divider(),

                    // =========================
                    // REVIEWS
                    // =========================
                    const _TitleWithArrow(
                      title: 'Reviews',
                    ),

                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'OUT OF 5',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        const Spacer(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                    (index) => const Icon(
                                  Icons.star,
                                  color: Color(0xFF4D9B88),
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '83 ratings',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const _RatingBar(
                      number: '5',
                      value: 0.80,
                      percent: '80%',
                    ),
                    const _RatingBar(
                      number: '4',
                      value: 0.12,
                      percent: '12%',
                    ),
                    const _RatingBar(
                      number: '3',
                      value: 0.05,
                      percent: '5%',
                    ),
                    const _RatingBar(
                      number: '2',
                      value: 0.03,
                      percent: '3%',
                    ),
                    const _RatingBar(
                      number: '1',
                      value: 0,
                      percent: '0%',
                    ),

                    const SizedBox(height: 15),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '47 Reviews',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'WRITE A REVIEW',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.edit,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Jennifer
                    const _ReviewItem(
                      image: 'assets/images/jennifer.png',
                      name: 'Jennifer Rose',
                      time: '5m ago',
                      review:
                      'I love it. Awesome customer service! Helped me out '
                          'with adding an additional item to my order. Thanks again!',
                    ),

                    const SizedBox(height: 25),

                    // Kelly
                    const _ReviewItem(
                      image: 'assets/images/kelly.png',
                      name: 'Kelly Rihana',
                      time: '9m ago',
                      review:
                      'I\'m very happy with order, it was delivered on '
                          'and good quality. Recommended!',
                    ),

                    const SizedBox(height: 25),
                    const Divider(),


                    // SIMILAR PRODUCTS
                    const _TitleWithArrow(
                      title: 'Similar Product',
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _SimilarProduct(
                            image: 'assets/images/Frame 33119.png',
                            name: 'Rise Crop Hoodie',
                            price: '\$ 43.00',
                          ),
                          _SimilarProduct(
                            image: 'assets/images/Frame 33118.png',
                            name: 'Gym Crop Top',
                            price: '\$ 39.99',
                          ),
                          _SimilarProduct(
                            image: 'assets/images/Frame 33120.png',
                            name: 'Sport Sweatshirt',
                            price: '\$ 47.99',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================================
// BUTON ROTUND - BACK / FAVORITE
// ========================================================

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const _CircleButton({
    required this.icon,
    required this.onPressed,
    this.iconColor = const Color(0xFF6E8495),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
          size: 19,
        ),
      ),
    );
  }
}

// ========================================================
// CULORI
// ========================================================

class _ColorCircle extends StatelessWidget {
  final Color color;

  const _ColorCircle({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}

// ========================================================
// SIZE
// ========================================================

class _SizeCircle extends StatelessWidget {
  final String text;
  final bool selected;

  const _SizeCircle({
    required this.text,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF444444)
            : const Color(0xFFF6F6F6),
        shape: BoxShape.circle,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: selected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

// ========================================================
// TITLU + SĂGEATĂ
// ========================================================

class _TitleWithArrow extends StatelessWidget {
  final String title;

  const _TitleWithArrow({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 22,
          ),
        ],
      ),
    );
  }
}

// ========================================================
// RATING BAR
// ========================================================

class _RatingBar extends StatelessWidget {
  final String number;
  final double value;
  final String percent;

  const _RatingBar({
    required this.number,
    required this.value,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 14,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
          const Icon(
            Icons.star,
            size: 12,
            color: Color(0xFF4D9B88),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 4,
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4D9B88),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 30,
            child: Text(
              percent,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================
// REVIEW
// ========================================================

class _ReviewItem extends StatelessWidget {
  final String image;
  final String name;
  final String time;
  final String review;

  const _ReviewItem({
    required this.image,
    required this.name,
    required this.time,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: List.generate(
                  5,
                      (index) => const Icon(
                    Icons.star,
                    size: 12,
                    color: Color(0xFF4D9B88),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                review,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ========================================================
// SIMILAR PRODUCT
// ========================================================

class _SimilarProduct extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const _SimilarProduct({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 130,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}