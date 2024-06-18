import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel/presentation/home/hotel_rooms_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../domain/models/user_model.dart';
import '../../providers/hotel_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController();
  String? userImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userImageUrl = userDoc.get('imagePath') ?? '';
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
      create: (_) => HotelProvider()..fetchHotels(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: userImageUrl != null && userImageUrl!.isNotEmpty
                          ? Image.network(
                              userImageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          'Welcome ${user?.email ?? ' '}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Icon(
                        Icons.search_off_rounded,
                        color: Color(0xff212435),
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(8),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xffffc6e0),
                                shape: BoxShape.circle,
                              ),
                              child: const ImageIcon(
                                NetworkImage(
                                    "https://cdn1.iconfinder.com/data/icons/basi-icon-set-01/100/Fin_copy-37-256.png"),
                                size: 24,
                                color: Color.fromARGB(255, 44, 179, 224),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                "Cities",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildCityItem(context, "Nairobi",
                              "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw="),
                          _buildCityItem(context, "Kisumu",
                              "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw="),
                          _buildCityItem(context, "Mombasa",
                              "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw="),
                          _buildCityItem(context, "Nyali",
                              "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw="),
                          _buildCityItem(context, "Eldoret",
                              "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw="),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, position) {
                        List<String> imageUrls = [
                          "https://media.istockphoto.com/id/1193996236/photo/scenic-of-night-urban-cityscape-skyline-and-golden-building-with-twilight-time.jpg?s=2048x2048&w=is&k=20&c=98Eh08jrwH9DQNxx1V7gUOjeEQoJXuX8T7AmVmFy90M=",
                          "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw=",
                          "https://media.istockphoto.com/id/1299026534/photo/nairobi-kenya.jpg?s=612x612&w=0&k=20&c=xwCQ441cTHFBTZpb8ihvVwqqtTZjmees1C3xdJc_nfw=",
                        ];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Image.network(
                            imageUrls[
                                position],                             height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: const ExpandingDotsEffect(
                            dotColor: Color(0xff9e9e9e),
                            activeDotColor: Color(0xff3a57e8),
                            dotHeight: 10,
                            dotWidth: 10,
                            radius: 16,
                            spacing: 8,
                            expansionFactor: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36.0),
              Consumer<HotelProvider>(
                builder: (context, provider, child) {
                  if (provider.hotels.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.hotels.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final hotel = provider.hotels[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HotelRoomsScreen(hotel: hotel),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  hotel.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    12.0), // Adjusted padding
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotel.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.italic,
                                          color:
                                              Color.fromARGB(255, 234, 0, 255)),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      hotel.location,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          hotel.rating.toString(),
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30.0), // Add some space after the button
              // Customer Reviews Section
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Reviews',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    _buildReviewItem(
                      context,
                      'John Doe',
                      'Absolutely amazing experience! The hotel staff was very friendly and the rooms were clean and spacious. Will definitely be returning soon!',
                      5,
                    ),
                    SizedBox(height: 20.0),
                    _buildReviewItem(
                      context,
                      'Jane Smith',
                      'Great location, comfortable beds, and excellent service. Highly recommended!',
                      4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityItem(
      BuildContext context, String cityName, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 60,
            width: 60,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            cityName,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, String reviewerName,
      String reviewText, int rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reviewerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '$rating',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          reviewText,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
