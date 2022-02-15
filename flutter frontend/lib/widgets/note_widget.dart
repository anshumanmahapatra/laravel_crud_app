import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/note_model.dart';

class NoteWidget {
  Container getNoteWidget(AsyncSnapshot<List<NoteModel>> snapshot, int index) {
    String timeago = showTimeAgo(snapshot.data![index].created);
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot.data![index].title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            snapshot.data![index].description,
            style: const TextStyle(color: Colors.white),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                timeago,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ],
      ),
    );
  }

  String showTimeAgo(String time) {
    String timePosted;
    DateTime parsedDate = DateTime.parse(time);
    DateTime now = DateTime.now();
    Duration difference = now.difference(parsedDate);
    timePosted = timeago.format(now.subtract(difference));
    return timePosted;
  }
}
