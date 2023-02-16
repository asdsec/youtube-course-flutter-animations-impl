import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}

@immutable
class Person {
  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });

  final String name;
  final int age;
  final String emoji;
}

const people = [
  Person(name: 'Sam', age: 23, emoji: '🤩'),
  Person(name: 'Foo', age: 25, emoji: '🥶'),
  Person(name: 'Bar', age: 27, emoji: '🤖'),
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsPage(person: person),
              ));
            },
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 35),
              ),
            ),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).chain(
                        CurveTween(
                          curve: Curves.easeInCirc,
                        ),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              '${person.age} years old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
