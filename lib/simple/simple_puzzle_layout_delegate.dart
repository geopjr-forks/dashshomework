// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dashshomework/colors/colors.dart';
import 'package:dashshomework/helpers/helpers.dart';
import 'package:dashshomework/l10n/l10n.dart';
import 'package:dashshomework/layout/layout.dart';
import 'package:dashshomework/models/models.dart';
import 'package:dashshomework/puzzle/puzzle.dart';
import 'package:dashshomework/simple/simple.dart';
import 'package:dashshomework/theme/theme.dart';
import 'package:dashshomework/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => SimpleStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    final col = Column(
      children: [
        const SimplePuzzleShuffleButton(),
        const SizedBox(height: 10),
        SimplePuzzleHintButton(
          rows: state.puzzle.rows,
          cols: state.puzzle.cols,
          positions: state.puzzle.positions,
        ),
        const SizedBox(height: 10),
        const SimplePuzzleAboutButton(),
      ],
    );

    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => col,
          medium: (_, child) => col,
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/notepad-lines.svg',
          fit: BoxFit.fill,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          left: 0,
          bottom: 10,
          child: SizedBox(
            width: 465.82,
            height: 181.77,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(15 / 360),
              child: SvgPicture.asset(
                'assets/images/doodle.svg',
                fit: BoxFit.fill,
                key: const Key('doodle'),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, __) => SizedBox(
              width: 184,
              height: 118,
              child: Image.asset(
                'assets/images/simple_dash_small.png',
                key: const Key('simple_puzzle_dash_small'),
              ),
            ),
            medium: (_, __) => SizedBox(
              width: 380.44,
              height: 214,
              child: Image.asset(
                'assets/images/simple_dash_medium.png',
                key: const Key('simple_puzzle_dash_medium'),
              ),
            ),
            large: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 53),
              child: SizedBox(
                width: 568.99,
                height: 320,
                child: Image.asset(
                  'assets/images/simple_dash_large.png',
                  key: const Key('simple_puzzle_dash_large'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget boardBuilder(
    int size,
    List<Widget> tiles,
    List<int> rows,
    List<int> cols,
  ) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => SizedBox.square(
            dimension: _BoardSize.small,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_small'),
              size: size,
              tiles: tiles,
              rows: rows,
              cols: cols,
              spacing: 5,
            ),
          ),
          medium: (_, __) => SizedBox.square(
            dimension: _BoardSize.medium,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_medium'),
              size: size,
              tiles: tiles,
              rows: rows,
              cols: cols,
            ),
          ),
          large: (_, __) => SizedBox.square(
            dimension: _BoardSize.large,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_large'),
              size: size,
              tiles: tiles,
              rows: rows,
              cols: cols,
            ),
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state, AudioPlayer audioPlayer) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        state: state,
        audioPlayer: audioPlayer,
      ),
      medium: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        state: state,
        audioPlayer: audioPlayer,
      ),
      large: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        state: state,
        audioPlayer: audioPlayer,
      ),
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class SimpleStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const SimpleStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        const ResponsiveGap(large: 16),
        SimplePuzzleTitle(
          status: state.puzzleStatus,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: state.numberOfTilesLeft,
        ),
        const ResponsiveGap(
          large: 32,
          small: 16,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => Column(
            children: [
              const SimplePuzzleShuffleButton(),
              const SizedBox(height: 10),
              SimplePuzzleHintButton(
                rows: state.puzzle.rows,
                cols: state.puzzle.cols,
                positions: state.puzzle.positions,
              ),
              const SizedBox(height: 10),
              const SimplePuzzleAboutButton(),
            ],
          ),
        ),
      ],
    );
  }
}

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTitle extends StatelessWidget {
  /// {@macro simple_puzzle_title}
  const SimplePuzzleTitle({
    Key? key,
    required this.status,
  }) : super(key: key);

  /// The status of the puzzle.
  final PuzzleStatus status;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      key: puzzleTitleKey,
      title: status == PuzzleStatus.complete
          ? context.l10n.puzzleCompleted
          : context.l10n.puzzleChallengeTitle,
    );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template simple_puzzle_board}
/// Display the board of the puzzle in a [size]x[size] layout
/// filled with [tiles]. Each tile is spaced with [spacing].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const SimplePuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
    required this.rows,
    required this.cols,
    this.spacing = 8,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The row results.
  final List<int> rows;

  /// The column results.
  final List<int> cols;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The spacing between each tile from [tiles].
  final double spacing;

  @override
  Widget build(BuildContext context) {
    const _textStyleSum = TextStyle(
      fontFamily: 'NanumPenScript',
      color: PuzzleColors.red100,
      fontWeight: PuzzleFontWeight.regular,
      fontSize: 40,
      // backgroundColor: Colors.white,
    );

    final children = <Widget>[];
    var x = 0;
    var y = 0;

    for (var i = 0; i < (size * size) + size; i++) {
      if ((i + 1) % (size + 1) == 0) {
        children.add(
          Center(
            child: Text(
              rows[y].toString(),
              textAlign: TextAlign.center,
              style: _textStyleSum,
            ),
          ),
        );
        y = y + 1;
      } else {
        children.add(tiles[x]);
        x = x + 1;
      }
    }

    for (var i = 0; i <= size; i++) {
      children.add(
        Center(
          child: Text(
            cols[i].toString(),
            textAlign: TextAlign.center,
            style: _textStyleSum,
          ),
        ),
      );
    }

    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size + 1,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: children,
    );
  }
}

abstract class _TileFontSize {
  static double small = 30;
  static double medium = 45;
  static double large = 54;
}

/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const SimplePuzzleTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
    required this.state,
    required this.audioPlayer,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  ///  The audio player.
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    return TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(fontSize: tileFontSize),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: PuzzleColors.blue100,
            width: 5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ).copyWith(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
          var borderColor = PuzzleColors.blue100;
          if (tile.value == state.lastTappedTile?.value) {
            borderColor = PuzzleColors.red100;
          } else if (states.contains(MaterialState.hovered)) {
            borderColor = PuzzleColors.red100;
          }
          return RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: 5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (tile.value == state.lastTappedTile?.value) {
              return PuzzleColors.red100;
            } else if (states.contains(MaterialState.hovered)) {
              return PuzzleColors.white;
            } else {
              return PuzzleColors.blue100;
            }
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (tile.value == state.lastTappedTile?.value) {
              return PuzzleColors.white;
            } else if (states.contains(MaterialState.hovered)) {
              return PuzzleColors.red100;
            } else {
              return theme.defaultColor;
            }
          },
        ),
      ),
      onPressed: () {
        if (state.puzzleStatus == PuzzleStatus.incomplete) {
          context.read<PuzzleBloc>().add(TileTapped(tile));
          unawaited(audioPlayer.replay());
        }
      },
      child: Text(
        tile.face.toString(),
        semanticsLabel: context.l10n.puzzleTileLabelText(
          tile.face.toString(),
          tile.currentPosition.x.toString(),
          tile.currentPosition.y.toString(),
        ),
      ),
    );
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PuzzleButton(
      textColor: PuzzleColors.primary0,
      backgroundColor: PuzzleColors.primary6,
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.puzzleShuffle,
            style: const TextStyle(fontFamily: 'NanumPenScript', fontSize: 30),
          ),
        ],
      ),
    );
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleAboutButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleAboutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('How to Play'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text(
                    'Dash got some homework to do and they need your help...',
                    style: TextStyle(fontSize: 25),
                  ),
                  const Gap(10),
                  const Text(
                    "What's their homework? A classic slide puzzle, but with a twist:",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(10),
                  const Text(
                    'Each row and each column has a red number next to it.',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(10),
                  const Text(
                    'That number is the sum of the correct tiles in that row or column.',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(10),
                  Table(
                    border: TableBorder.all(color: const Color(0x11000000)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: const [
                      TableRow(
                        children: [
                          Center(child: Text('84')),
                          Center(child: Text('+')),
                          Center(child: Text('00')),
                          Center(child: Text('+')),
                          Center(child: Text('74')),
                          Center(child: Text('+')),
                          Center(child: Text('16')),
                          Center(child: Text('=')),
                          Center(child: Text('174'))
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Text(' ')
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('87')),
                          Center(child: Text('+')),
                          Center(child: Text('38')),
                          Center(child: Text('+')),
                          Center(child: Text('69')),
                          Center(child: Text('+')),
                          Center(child: Text('10')),
                          Center(child: Text('=')),
                          Center(child: Text('204'))
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Text(' ')
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('44')),
                          Center(child: Text('+')),
                          Center(child: Text('24')),
                          Center(child: Text('+')),
                          Center(child: Text('32')),
                          Center(child: Text('+')),
                          Center(child: Text('62')),
                          Center(child: Text('=')),
                          Center(child: Text('162'))
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Center(child: Text('+')),
                          Center(child: Text('')),
                          Text(' ')
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('91')),
                          Center(child: Text('+')),
                          Center(child: Text('86')),
                          Center(child: Text('+')),
                          Center(child: Text('19')),
                          Center(child: Text('+')),
                          Center(child: Text('00')),
                          Center(child: Text('=')),
                          Center(child: Text('196'))
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('=')),
                          Center(child: Text('')),
                          Center(child: Text('=')),
                          Center(child: Text('')),
                          Center(child: Text('=')),
                          Center(child: Text('')),
                          Center(child: Text('=')),
                          Center(child: Text('')),
                          Text(' ')
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('306')),
                          Text(' '),
                          Center(child: Text('148')),
                          Text(' '),
                          Center(child: Text('194')),
                          Text(' '),
                          Center(child: Text('88')),
                          Text(' '),
                          Center(child: Text('154'))
                        ],
                      )
                    ],
                  ),
                  const Gap(10),
                  const Text(
                    "There's also the diagonal sum, but keep in mind the right-bottom tile\nwill always be whitespace = 0.",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(10),
                  const Text(
                    'Tip: Press the "Solution" button to see the solution of the current puzzle.',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return PuzzleButton(
      textColor: PuzzleColors.primary0,
      backgroundColor: PuzzleColors.primary6,
      onPressed: _showMyDialog,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'How To',
            style: TextStyle(fontFamily: 'NanumPenScript', fontSize: 30),
          ),
        ],
      ),
    );
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleHintButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleHintButton({
    Key? key,
    required this.rows,
    required this.cols,
    required this.positions,
  }) : super(key: key);

  /// rows
  final List<int> rows;

  /// cols
  final List<int> cols;

  /// correct positions
  final List<List<int>> positions;

  @override
  Widget build(BuildContext context) {
    final textWidgets = <List<Widget>>[];

    for (var x = 0; x < positions.length; x++) {
      final rowWidgets = <Widget>[];
      for (var y = 0; y < positions[x].length; y++) {
        final digit =
            (positions[x][y] < 10 ? '0' : '') + positions[x][y].toString();
        rowWidgets.add(Center(child: Text(digit, softWrap: false)));
        if (y != positions[x].length - 1) {
          rowWidgets.add(const Center(child: Text('+')));
        }
      }
      rowWidgets
        ..add(const Center(child: Text('=')))
        ..add(Center(child: Text(rows[x].toString(), softWrap: false)));

      final symbolWidgets = <Widget>[];
      final joiner = x != positions.length - 1 ? '+' : '=';

      for (var i = 0; i < positions[x].length * 2; i++) {
        symbolWidgets.add(Center(child: Text(i.isEven ? joiner : ' ')));
      }
      symbolWidgets.add(const Text(' '));

      textWidgets
        ..add(rowWidgets)
        ..add(symbolWidgets);
    }

    final colWidgets = <Widget>[];
    for (var x = 0; x < cols.length; x++) {
      colWidgets.add(Center(child: Text(cols[x].toString(), softWrap: false)));
      if (x != cols.length - 1) colWidgets.add(const Text(' '));
    }
    textWidgets.add(colWidgets);

    final tableRows = <TableRow>[];
    for (var x = 0; x < textWidgets.length; x++) {
      tableRows.add(TableRow(children: textWidgets[x]));
    }

    final table = Table(
      border: TableBorder.all(color: const Color(0x11000000)),
      children: tableRows,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    );

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Solution'),
            content: SingleChildScrollView(
              child: table,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return PuzzleButton(
      textColor: PuzzleColors.primary0,
      backgroundColor: PuzzleColors.primary6,
      onPressed: _showMyDialog,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Solution',
            style: TextStyle(fontFamily: 'NanumPenScript', fontSize: 30),
          ),
        ],
      ),
    );
  }
}
