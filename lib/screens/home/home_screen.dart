import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/shared/components/appbar_back_btn.dart';
import 'package:zappy_meal/shared/components/avatar_circle.dart';
import 'package:zappy_meal/shared/components/chip.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/filter_icon.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shadow.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool? _serviceEnabled;
  Position? _userLocation;
  Set<Marker> _markers = {};

  String lat = "0";
  String long = "0";

  initstate() {
    // showRestaurantBottomSheet();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () => showRestaurantBottomSheet(context)),
      appBar: AppBar(
        // leadingWidth: 50.w,
        toolbarHeight: 60.h,
        leading: appBarBackButton(context: context, icon: SvgPicture.asset(AppIcons.menu), onTap: () {}),
        actions: [
          filterIcon(context),
          kwSpacer(10.w),
          avatarCircle(context: context, radius: 19.r, circleColor: Theme.of(context).primaryColor),
          kwSpacer(10.w),
        ],
      ),
      bottomSheet: homeBottomSheet(context),
      body: Container(
        color: Theme.of(context).cardColor,
        child: GoogleMap(
          markers: _markers,
          // minMaxZoomPreference: MinMaxZoomPreference(100.0, 200.0),
          onTap: (location) => {
            logI(location),
            setState(() {
              lat = location.latitude.toStringAsFixed(4);
              long = location.longitude.toStringAsFixed(4);
            })
          },
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) async {
            _mapController.complete(controller);

            //* Creates Marker on current user location, using a current icon.
            final userLocation = Marker(
              markerId: MarkerId('user-location'),
              icon: BitmapDescriptor.defaultMarker,
              position: _kGooglePlex.target,
            );

            setState(() => _markers.add(userLocation));
          },
        ),
      ),
    );
  }

  Container homeBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      height: 250.h,
      width: kwidth(context),
      padding: kpadding(0, 15.h),
      child: Column(
        children: [
          Padding(
            padding: kph(10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      chip(context: context, title: "Nearby", onTap: () {}, icon: AppIcons.check, color: Theme.of(context).primaryColor),
                      kwSpacer(10.w),
                      chip(context: context, title: "Popular", onTap: () {}, icon: AppIcons.dot, color: Theme.of(context).highlightColor),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.restaurant_listing),
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp, color: Theme.of(context).primaryColor),
                      ),
                      kwSpacer(10.w),
                      Icon(Icons.arrow_forward_rounded, color: Theme.of(context).primaryColor),
                    ],
                  ),
                )
              ],
            ),
          ),
          kh20Spacer(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return restaurantCard(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container restaurantCard(BuildContext context) {
    return Container(
      margin: kph(10.w),
      width: kwidth(context) * 0.4,
      decoration: BoxDecoration(
        borderRadius: radiusL(),
        boxShadow: appShadowSm(context),
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          coverImage(context: context, height: 100.h, borderRadius: 20.r),
          Positioned(
            bottom: 10,
            child: Container(
              width: kwidth(context) * 0.4,
              // height: 100.h,
              decoration: BoxDecoration(
                borderRadius: radiusL(),
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: kpadding(10.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                        width: 85.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        padding: kpadding(5.w, 5.h),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.send_envelop),
                            kwSpacer(5.w),
                            Text("Less Than 500 m", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 7.sp)),
                          ],
                        ),
                      ),
                    ),
                    khSpacer(5.h),
                    Text("Restaurant H", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor)),
                    khSpacer(5.h),
                    Row(
                      children: List.generate(
                        4,
                        (index) => SvgPicture.asset(AppIcons.star, width: 15.w),
                      ),
                    ),
                    khSpacer(5.h),
                    SizedBox(
                      width: kwidth(context) * 0.4,
                      child: Text(
                        "Douala Denver, Makepe Denv",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
