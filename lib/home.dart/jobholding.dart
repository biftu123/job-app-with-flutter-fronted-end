import 'package:flutter/material.dart';

import 'package:jobapp/model/response/jobresponsemodel.dart';

class JobHolding extends StatelessWidget {
  const JobHolding({
    Key? key,
    this.onTap, required this.job,
  }) : super(key: key);

  final void Function()? onTap;
   final JobResponse job;
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Flexible(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            // Remove unnecessary width constraint (unless strictly needed)
            // width: MediaQuery.of(context).size.width * 0.28,
            padding: const EdgeInsets.all(20.0), // Consistent padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                 color: Color.fromARGB(255, 151, 150, 150),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
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
                      backgroundImage:NetworkImage(job.imageUrl) // Use const for assets
                    ),
                           const SizedBox(width:12.0),
                     Text(
                        job.company,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    
                  ],
                ),
              
                Text(
                  job.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  
                  children: [
                    
                    Text(
                      job.salary,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                     
                    Text(
                    " / ${job.contract}",
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
