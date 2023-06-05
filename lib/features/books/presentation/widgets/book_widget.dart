import 'package:flutter/material.dart';
import 'package:new_york_time_api/features/books/domain/entities/buy_links_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class BookWidget extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final String bookPrice;
  final String? bookImage;
  final String bookDescription;
  final List<BuyLinkEntiy> bookUrls;
  const BookWidget(
      {Key? key,
      required this.bookAuthor,
      required this.bookPrice,
      required this.bookTitle,
      required this.bookImage,
      required this.bookDescription,
      this.bookUrls = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            context: context,
            builder: (context) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text("$bookTitle by \n $bookAuthor",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(bookDescription,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 20)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: bookUrls.isNotEmpty
                          ? bookUrls
                              .map<Widget>((e) => GestureDetector(
                                  onTap: () async =>
                                      await launchUrl(Uri.parse(e.url)),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            e.name,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                          const Icon(
                                            Icons.open_in_new,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                  )))
                              .toList()
                          : [Container()],
                    )
                  ]),
                ));
      },
      child: Container(
        color: Colors.transparent,
        width: 200,
        height: 250,
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(bookImage ??
                            "https://www.shutterstock.com/image-vector/book-icon-sign-design-260nw-553945819.jpg"))),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 220,
                height: 200,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 15)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      bookTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      bookDescription,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      bookAuthor,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: const [
                        Text("See more",
                            style: const TextStyle(color: Colors.grey)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
