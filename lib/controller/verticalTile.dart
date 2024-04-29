import 'package:flutter/material.dart';
import 'package:jobapp/model/response/jobresponsemodel.dart';

class verticaltile extends StatelessWidget {
  const verticaltile({
    Key? key,
    this.onTap, this.job,
  }) : super(key: key);

  final void Function()? onTap;
  final JobResponse? job;
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
            // Remove unnecessary width constraint (unless strictly needed)
            // width: MediaQuery.of(context).size.width * 0.28,
            padding: const EdgeInsets.all(20.0), // Consistent padding
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
                          job!.imageUrl), // Use const for assets
                    ),
                    
                    Text(
                      job!.company,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job!.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                Row(
                  children: [
                    Text(
                      job!.salary,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '/ ${job!.contract}',
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
