import 'package:flutter/material.dart';

class QDetailsModal2 extends StatelessWidget {
  const QDetailsModal2({
    super.key,
    required this.qDetails,
  });

  final List<Map<String, dynamic>> qDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: ListView(
          children: [
            Center(
              child: Text(
                "QDetails 2/2",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QCoverage",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QRiskCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QPremCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QBeneCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QSumAssured",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QEmrRating",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      "QAgeAdmitted",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
