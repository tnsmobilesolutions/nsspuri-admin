// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/utilities/network_helper.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Row(
        children: [
          const Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 60.00,
              width: 60.00),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 300,
                //Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
                child: Text(
                  'Sammilani Delegate',
                  style: TextStyle(color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              //const SizedBox(height: 10),
              SizedBox(
                width: 300,
                //Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
                child: Text(
                  "${NetworkHelper().getCurrentDevotee?.name} (${NetworkHelper().getCurrentDevotee?.role})",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              // SizedBox(
              //   width:
              //       Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
              //   child: Text(
              //     "${NetworkHelper().getCurrentDevotee?.role}",
              //     style: const TextStyle(color: Colors.white, fontSize: 15),
              //     softWrap: true,
              //     overflow: TextOverflow.clip,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class TitleAppBarTablet extends StatelessWidget {
  const TitleAppBarTablet({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Row(
        children: [
          const Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 60.00,
              width: 60.00),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 300,
                //Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
                child: Text(
                  'Sammilani Delegate',
                  style: TextStyle(color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              //const SizedBox(height: 10),
              SizedBox(
                width: 300,
                //Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
                child: Text(
                  "${NetworkHelper().getCurrentDevotee?.name} (${NetworkHelper().getCurrentDevotee?.role})",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              // SizedBox(
              //   width:
              //       Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
              //   child: Text(
              //     "${NetworkHelper().getCurrentDevotee?.role}",
              //     style: const TextStyle(color: Colors.white, fontSize: 15),
              //     softWrap: true,
              //     overflow: TextOverflow.clip,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class TitleAppBarMobile extends StatelessWidget {
  const TitleAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          const Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 60.00,
              width: 60.00),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sammilani Delegate',
                style: TextStyle(color: Colors.white, fontSize: 17),
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
              Text(
                "${NetworkHelper().getCurrentDevotee?.name})",
                style: const TextStyle(color: Colors.white, fontSize: 14),
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
              Text(
                "${NetworkHelper().getCurrentDevotee?.role}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
