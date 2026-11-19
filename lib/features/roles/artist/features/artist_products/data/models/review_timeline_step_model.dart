enum ReviewStepStatus {
  completed,
  active,
  pending,
}

class ReviewTimelineStepModel {
  final int stepNumber;
  final String title;
  final String description;
  final String? timestamp;
  final ReviewStepStatus status;
  final String? actionButtonText;
  final String? actionRoute;

  const ReviewTimelineStepModel({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.timestamp,
    required this.status,
    this.actionButtonText,
    this.actionRoute,
  });

  static List<ReviewTimelineStepModel> getSampleSteps() {
    return const [
      ReviewTimelineStepModel(
        stepNumber: 1,
        title: 'Submitted',
        description: 'Product details & images received',
        timestamp: 'Jun 15, 2026 • 11:10 AM',
        status: ReviewStepStatus.completed,
      ),
      ReviewTimelineStepModel(
        stepNumber: 2,
        title: 'Awaiting Review',
        description: 'Admin team is reviewing your submission',
        timestamp: 'Jun 15, 2026 • 11:10 AM',
        status: ReviewStepStatus.completed,
      ),
      ReviewTimelineStepModel(
        stepNumber: 3,
        title: 'Admin Contacts Artist',
        description: 'Admin is ready to coordinate delivery',
        timestamp: 'Jun 15, 2026 • 11:10 AM',
        status: ReviewStepStatus.active,
        actionButtonText: 'Respond to Admin >',
      ),
      ReviewTimelineStepModel(
        stepNumber: 4,
        title: 'Artist Delivers Sample',
        description: 'Drop off your product at our Lagos office',
        status: ReviewStepStatus.pending,
      ),
      ReviewTimelineStepModel(
        stepNumber: 5,
        title: 'Product Inspection',
        description: 'Our team physically inspects quality & authenticity',
        status: ReviewStepStatus.pending,
      ),
      ReviewTimelineStepModel(
        stepNumber: 6,
        title: 'Professional Photoshoot',
        description: 'Studio-quality photos taken by our team',
        status: ReviewStepStatus.pending,
      ),
      ReviewTimelineStepModel(
        stepNumber: 7,
        title: 'Admin Publishes Product',
        description: 'Listing goes live on Riddim Africa marketplace',
        status: ReviewStepStatus.pending,
      ),
    ];
  }
}
