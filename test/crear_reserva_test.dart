import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime hora(int h, [int m = 0]) => DateTime(2026, 10, 14, h, m);

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  test('acepta una reserva válida y la guarda', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva cuyo fin no es posterior al inicio', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(9),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La hora de fin debe ser posterior a la de inicio');
    expect(repositorio.reservas, isEmpty);
  });

  final casosSolapamiento = <({
    String nombre,
    String salaId,
    DateTime inicio,
    DateTime fin,
    bool aceptada,
  })>[
    (
      nombre: 'solapamiento parcial al inicio',
      salaId: 'Sala A',
      inicio: hora(8, 30),
      fin: hora(9, 30),
      aceptada: false,
    ),
    (
      nombre: 'solapamiento parcial al final',
      salaId: 'Sala A',
      inicio: hora(9, 30),
      fin: hora(10, 30),
      aceptada: false,
    ),
    (
      nombre: 'intervalo contenido dentro de la reserva existente',
      salaId: 'Sala A',
      inicio: hora(9, 15),
      fin: hora(9, 45),
      aceptada: false,
    ),
    (
      nombre: 'intervalo que contiene la reserva existente',
      salaId: 'Sala A',
      inicio: hora(8, 30),
      fin: hora(10, 30),
      aceptada: false,
    ),
    (
      nombre: 'intervalo exactamente igual',
      salaId: 'Sala A',
      inicio: hora(9),
      fin: hora(10),
      aceptada: false,
    ),
    (
      nombre: 'intervalo anterior que termina cuando empieza el existente',
      salaId: 'Sala A',
      inicio: hora(8),
      fin: hora(9),
      aceptada: true,
    ),
    (
      nombre: 'intervalo posterior que empieza cuando termina el existente',
      salaId: 'Sala A',
      inicio: hora(10),
      fin: hora(11),
      aceptada: true,
    ),
    (
      nombre: 'intervalo separado antes de la reserva existente',
      salaId: 'Sala A',
      inicio: hora(8),
      fin: hora(8, 30),
      aceptada: true,
    ),
    (
      nombre: 'intervalo separado después de la reserva existente',
      salaId: 'Sala A',
      inicio: hora(10, 30),
      fin: hora(11),
      aceptada: true,
    ),
    (
      nombre: 'intervalo solapado en otra sala',
      salaId: 'Sala B',
      inicio: hora(9, 30),
      fin: hora(10, 30),
      aceptada: true,
    ),
  ];

  for (final caso in casosSolapamiento) {
    test('solapamiento: ${caso.nombre}', () async {
      await crearReserva(SolicitudReserva(
        salaId: 'Sala A',
        usuarioId: 'u1',
        inicio: hora(9),
        fin: hora(10),
      ));

      final resultado = await crearReserva(SolicitudReserva(
        salaId: caso.salaId,
        usuarioId: 'u2',
        inicio: caso.inicio,
        fin: caso.fin,
      ));

      expect(resultado.aceptada, caso.aceptada);
      if (caso.aceptada) {
        expect(repositorio.reservas, hasLength(2));
      } else {
        expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
        expect(repositorio.reservas, hasLength(1));
      }
    });
  }
}
