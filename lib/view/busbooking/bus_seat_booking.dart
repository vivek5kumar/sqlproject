import 'package:flutter/material.dart';
import 'package:path/path.dart';

class BusBooking extends StatefulWidget {
  const BusBooking({super.key});

  @override
  State<BusBooking> createState() => _BusBookingState();
}

class _BusBookingState extends State<BusBooking> {
  // bool isButtonActive = true;
  // var isBooking
  var countSeatLeft = 3 * 10;
  var countSeatCenter = 4 * 10;
  var countSeatRight = 3 * 10;

// seta list
  var listSeatLeft = [];
  var listSeatCenter = [];
  var listSeatRight = [];

  @override
  void initState() {
    initialSeatValueToList(listSeatLeft, countSeatLeft, "l");
    initialSeatValueToList(listSeatCenter, countSeatCenter, "c");
    initialSeatValueToList(listSeatRight, countSeatRight, "r");
    setVisisbilitySeat();
    super.initState();
  }

  initialSeatValueToList(List data, count, side) {
    var objectData;
    for (int i = 0; i < count; i++) {
      objectData = {
        "id": side + "${i + 1}",
        "isBooked": false,
        "isAvailable": true,
        "isSelected": false,
        "isVisible": true,
      };
      setState(() {
        data.add(objectData);
      });
    }
    print(data);
  }

  setVisisbilitySeat() {
    setState(() {
      listSeatLeft[0]["isVisible"] = false;
      listSeatLeft[1]["isVisible"] = false;
      listSeatLeft[3]["isVisible"] = false;
      listSeatRight[1]["isVisible"] = false;
      listSeatRight[2]["isVisible"] = false;
      listSeatRight[5]["isVisible"] = false;
    });
  }

  setSelectToBooking() {
    listSeatLeft.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    });
    listSeatCenter.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    });
    listSeatRight.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: const Text("Seat Booking"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Text("Screen"),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      const Text("Booked")
                    ],
                  )),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all()),
                        ),
                        const Text("Selected")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Text("Available")
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(child: widgetSeat(listSeatLeft, false))),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(child: widgetSeat(listSeatCenter, true)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(child: widgetSeat(listSeatRight, false)),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: setSelectToBooking(), child: const Text("Booking"))
          ],
        ),
      ),
    );
  }

  Widget widgetSeat(List dataSeat, bool isCenter) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isCenter ? 4 : 3,
            childAspectRatio: isCenter ? 0.67 : 0.9),
        itemCount: dataSeat.length,
        itemBuilder: (context, index) {
          return Visibility(
            visible: dataSeat[index]["isVisible"],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  dataSeat[index]["isSelected"] =
                      !dataSeat[index]["isSelected"];
                });
              },
              child: Container(
                width: 88,
                margin: const EdgeInsets.all(5),
                // width: 50,
                // height: 50,
                decoration: BoxDecoration(
                    color: dataSeat[index]["isBooked"]
                        ? Colors.green
                        : dataSeat[index]["isSelected"]
                            ? Colors.white
                            : Colors.transparent,
                    border: Border.all(color: Colors.grey)),

                // child: ,
              ),
            ),
          );
        });
  }
}
