import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kiteby/screens/views/splash/onboarding_screen.dart';
import 'package:kiteby/screens/views/welcome/welcome-secreen.dart';

// NOTE: KitebyApp itself is not tested here because its first route is the
// splash screen, which reads Supabase auth state and schedules a navigation
// timer. Testing it would require initializing Supabase against a live
// project. These tests cover the screens that are pure UI.

void main() {
  testWidgets('Onboarding shows the first page and can advance', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Read Books'), findsOneWidget);
    expect(find.text('Skip Intro'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.text('Review Them'), findsOneWidget);
  });

  testWidgets('Onboarding language menu opens', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('English'), findsNothing);

    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
    expect(find.text('Français'), findsOneWidget);
  });

  testWidgets('Welcome screen renders its call to action', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Get Started Now'), findsOneWidget);
  });
}
