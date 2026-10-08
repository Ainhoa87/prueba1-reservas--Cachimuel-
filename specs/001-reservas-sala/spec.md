# Feature Specification: Reservas de sala

**Feature Branch**: `001-reservas-sala`
**Created**: 2026-10-01
**Status**: Draft

## User Scenarios & Testing

### User Story 1 — Reservar una sala (Priority: P1)

Como estudiante autenticado, quiero reservar una sala de estudio por un intervalo de tiempo
para tener dónde trabajar con mi grupo.

**Why this priority**: sin reservas, la app no tiene propósito.

**Independent Test**: se puede probar creando una reserva y comprobando que queda registrada.

**Acceptance Scenarios**:

1. **Dado** que la sala A está libre, **Cuando** la reservo de 09:00 a 10:00, **Entonces** la
   reserva queda registrada a mi nombre.
2. **Dado** que elijo como inicio las 10:00 y como fin las 09:00, **Cuando** intento reservar,
   **Entonces** la reserva se rechaza con el mensaje "La hora de fin debe ser posterior a la de inicio".
3. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   esa misma sala de 09:30 a 10:30, **Entonces** la reserva se rechaza con el mensaje exacto
   "La sala ya está reservada en ese horario".
4. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   esa misma sala de 09:15 a 09:45, **Entonces** la reserva se rechaza con el mensaje exacto
   "La sala ya está reservada en ese horario".
5. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   esa misma sala de 08:30 a 10:30, **Entonces** la reserva se rechaza con el mensaje exacto
   "La sala ya está reservada en ese horario".
6. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   esa misma sala de 09:00 a 10:00, **Entonces** la reserva se rechaza con el mensaje exacto
   "La sala ya está reservada en ese horario".
7. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   esa misma sala de 10:00 a 11:00, **Entonces** la reserva queda registrada, porque los intervalos
   que solo comparten un extremo no se solapan.
8. **Dado** que ya existe una reserva para la sala A de 09:00 a 10:00, **Cuando** intento reservar
   la sala B de 09:30 a 10:30, **Entonces** la reserva queda registrada, porque las reservas de
   salas distintas no se solapan entre sí.

### Edge Cases

- Dos reservas de la misma sala se solapan cuando comparten cualquier parte del intervalo, aunque
  una esté contenida dentro de la otra o ambas tengan exactamente las mismas horas.
- El inicio de cada intervalo está incluido y el fin está excluido; por eso, una reserva que empieza
  exactamente cuando termina otra no se solapa con ella.

## Requirements

### Functional Requirements

- **FR-001**: El estudiante elige una sala, una hora de inicio y una hora de fin.
- **FR-002**: Una reserva confirmada queda registrada a nombre del estudiante para la sala y el
  intervalo elegidos.
- **FR-003**: La hora de fin debe ser posterior a la hora de inicio.
- **FR-004**: No se confirma una reserva si su intervalo se solapa con el de otra reserva de la
  misma sala. Se consideran intervalos con inicio incluido y fin excluido; compartir únicamente el
  instante de inicio o fin no constituye solapamiento.
- **FR-005**: Si el intervalo solicitado se solapa con otra reserva de la misma sala, la reserva se
  rechaza con el mensaje exacto "La sala ya está reservada en ese horario".
- **FR-006**: Las reservas de salas distintas no se excluyen entre sí, aunque sus intervalos se
  solapen.

### Key Entities

- **Reserva**: sala, estudiante, inicio y fin.
- **Sala**: identificada por su nombre (Sala A, Sala B, Sala C).

## Success Criteria

- **SC-001**: Un estudiante completa una reserva en menos de 30 segundos.
