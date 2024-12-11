import 'package:flutter/material.dart';

class CourseWishlistScreen extends StatefulWidget {
  const CourseWishlistScreen({super.key});

  @override
  _CourseWishlistScreenState createState() => _CourseWishlistScreenState();
}

class _CourseWishlistScreenState extends State<CourseWishlistScreen> {
  // Sample course data with more detailed time and rating information
  final List<Map<String, dynamic>> _wishlistCourses = [
    {
      'title': 'Advanced Web Development',
      'instructor': 'John Smith',
      'level': 'Advanced',
      'price': 0.00,
      'totalHours': 42,
      'weeklyCommitment': 7,
      'image': 'assets/course.png',
      'category': 'Programming',
      'rating': 4.5,
      'totalRatings': 1205,
      'completionTime': 'Approx. 6 weeks',
    },
    {
      'title': 'Data Science Fundamentals',
      'instructor': 'Emily Rodriguez',
      'level': 'Intermediate',
      'price': 0.00,
      'totalHours': 30,
      'weeklyCommitment': 5,
      'image': 'assets/course1.png',
      'category': 'Data Analysis',
      'rating': 4.7,
      'totalRatings': 890,
      'completionTime': 'Approx. 4 weeks',
    },
    {
      'title': 'UX Design Masterclass',
      'instructor': 'Michael Chen',
      'level': 'Beginner',
      'price': 0.00,
      'totalHours': 24,
      'weeklyCommitment': 4,
      'image': 'assets/course.png',
      'category': 'Design',
      'rating': 4.3,
      'totalRatings': 567,
      'completionTime': 'Approx. 3 weeks',
    },
  ];

  // Star rating widget
  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16, // Reduced size
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Future Learning Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18, // Slightly smaller font
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black87),
            onPressed: () {
              // Add new course to wishlist
            },
          ),
        ],
      ),
      body: ListView(
        // Reduced padding
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        children: [
          // Wishlist Summary
          _buildWishlistSummary(),
          const SizedBox(height: 24),

          // Wishlist Courses
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Courses to Learn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Course List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _wishlistCourses.length,
            itemBuilder: (context, index) {
              return _buildCourseCard(_wishlistCourses[index]);
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildWishlistSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Future Learning Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${_wishlistCourses.length} Courses Planned',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Edit Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12), // Reduced padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            Container(
              width: 70, // Slightly smaller
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(course['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Course Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${course['instructor']} • ${course['category']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Rating and Level Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Star Rating
                      Row(
                        children: [
                          _buildStarRating(course['rating']),
                          SizedBox(width: 6),
                          Text(
                            '(${course['totalRatings']})',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),

                      // Level Chip
                      Chip(
                        label: Text(
                          course['level'],
                          style: TextStyle(
                            color: _getLevelColor(course['level']),
                            fontSize: 11,
                          ),
                        ),
                        backgroundColor:
                            _getLevelColor(course['level']).withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Learning Time Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total Hours
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blue, size: 14),
                          SizedBox(width: 4),
                          Text(
                            '${course['totalHours']} hrs',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),

                      // Weekly Commitment
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.green, size: 14),
                          SizedBox(width: 4),
                          Text(
                            '${course['weeklyCommitment']} hrs/week',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Completion Time
                  Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '${course['completionTime']}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Free Course Indicator
                  Text(
                    'FREE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            Column(
              children: [
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.remove_circle_outline,
                      color: Colors.red[300], size: 20),
                  onPressed: () {
                    // Remove from wishlist
                  },
                ),
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.bookmark_add, color: Colors.blue, size: 20),
                  onPressed: () {
                    // Mark as priority or add to learning plan
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.grey),
            onPressed: () {
              // Navigate to home
            },
          ),
          IconButton(
            icon: Icon(Icons.book, color: Colors.blue),
            onPressed: () {
              // Current page
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: Colors.grey),
            onPressed: () {
              // Add new course
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
    );
  }
}
