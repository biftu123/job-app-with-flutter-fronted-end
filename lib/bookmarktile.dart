import 'package:flutter/material.dart';
import 'package:jobapp/model/response/allbookmark.dart';

class Bookmarktile extends StatelessWidget {
  const Bookmarktile({
    Key? key,
    this.onTap,
    required this.job,
  }) : super(key: key);

  final void Function()? onTap;
  final AllbookMark job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 151, 150, 150),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        job.job.imageUrl, // Use null-aware operator and provide a default value
                      ),
                    ),
                    Text(
                      job.job.company , // Use null-aware operator and provide a default value
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.job.title, // Use null-aware operator and provide a default value
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      job.job.salary, // Use null-aware operator and provide a default value
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '/ ${job.job.contract }', // Use null-aware operator and provide a default value
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}