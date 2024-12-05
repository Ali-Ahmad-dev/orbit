import 'package:flutter/material.dart';

dynamicSettingModalBottomSheet(
  context,
) async {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      )
      ),
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 50.0,
                height: 2.0,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                width: 50.0,
                height: 2.0,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.042,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Colors.blue),
                          minimumSize: const Size(120, 50),
                          maximumSize: const Size(120, 50),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      }
      );
}
