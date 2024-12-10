import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      body: SafeArea(
        child: Column(
          children: [
        
            _buildCourseFilterTabs(),
            Expanded(
              child: _buildCoursesList(),
            ),
          ],
        ),
      ),
    );
  }

 

  Widget _buildCourseFilterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterTab('All', isSelected: true),
          _buildFilterTab('Ongoing'),
          _buildFilterTab('Completed'),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        border: Border.all(color: Colors.black, width: 0.50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCoursesList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _buildCourseItem(
          title: 'Expand your knowledge with these engaging courses',
          instructor: 'Angela Yhu - Teaching Position',
          progress: 0.4,
          completionText: '40% Completed',
        ),
        _buildCourseItem(
          title: 'Expand your knowledge with these engaging courses',
          instructor: 'Angela Yhu - Teaching Position',
          progress: 0.9,
          completionText: '90% Completed',
        ),
        _buildCourseItem(
          title: 'Expand your knowledge with these engaging courses',
          instructor: 'Angela Yhu - Teaching Position',
          progress: 0.6,
          completionText: '60% Completed',
        ),
        _buildCourseItem(
          title: 'Expand your knowledge with these engaging courses',
          instructor: 'Angela Yhu - Teaching Position',
          progress: 0.8,
          completionText: '80% Completed',
        ),
        _buildCompletedCourseItem(),
      ],
    );
  }

  Widget _buildCourseItem({
    required String title,
    required String instructor,
    required double progress,
    required String completionText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgcHSWvxLkHR781PGJbamZoUVebRwupxCdlg&s"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  instructor,
                  style: const TextStyle(
                    color: Color(0xFF3F3F3F),
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                _buildProgressBar(progress),
                const SizedBox(height: 4),
                Text(
                  completionText,
                  style: const TextStyle(
                    color: Color(0xFF3F3F3F),
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Stack(
      children: [
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0x7F525FE1),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Container(
          width: progress * 300, // Adjust based on your design
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFF525FE1),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedCourseItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHvCgY7kKcvTAwr-bJLi_-SYvFEyhUbI-jDA&s"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expand your knowledge with these engaging courses',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Angela Yhu - Teaching Position',
                  style: TextStyle(
                    color: Color(0xFF3F3F3F),
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF525FE1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'COMPLETED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
