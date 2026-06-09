import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'survey_viewmodel.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final SurveyViewModel vm = SurveyViewModel();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await vm.loadQuestions();

    setState(() {
      loading = false;
    });
  }

  Future<void> sendEmail() async {
    final body = vm.buildEmailBody();

    final Uri emailUri = Uri.parse(
      'mailto:malvasala@gmail.com'
      '?subject=${Uri.encodeComponent("Resultados Encuesta ARMeasure")}'
      '&body=${Uri.encodeComponent(body)}',
    );

    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorización"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: vm.questions.length,
                itemBuilder: (context, index) {
                  final q = vm.questions[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.question,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Row(
                            children: [
                              Text(
                                "No",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Sí",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              q.max,
                              (i) {
                                final value = i + 1;

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      value.toString(),
                                    ),
                                    Radio<int>(
                                      value: value,
                                      groupValue:
                                          vm.answers[q.id],
                                      onChanged: (v) {
                                        setState(() {
                                          vm.saveAnswer(
                                            q.id,
                                            v!,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (vm.allAnswered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: sendEmail,
                  child: const Text(
                    "Enviar",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}