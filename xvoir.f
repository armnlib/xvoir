      program xvoir
      IMPLICIT NONE
      integer maxrecs
      parameter (MAXRECS= 24576)
      integer liste(24576)
      INTEGER BUF(1)
      INTEGER IPTAB
      REAL    ASPRAT
      character*4 nomvar
      character*2 typvar 
      character*1 grtyp,cdatyp
      character*12 etiket
      character*160  titre
      INTEGER KEY, DATE0, DEET, NPAS, NI, NJ, NK, NBITS, DATYP 
      INTEGER IP1, IP2, IP3, SWA, LNG, DLTF, UBC
      INTEGER IG1, IG2, IG3, IG4, EXTRA1, EXTRA2, EXTRA3
      INTEGER FSTOUV, FSTINF, fstinl, FSTLUK, FSTPRM, FSTSUI 
      INTEGER FNOM, FSTFRM, RES, nrecs, nbrecs, niun
      integer selrec
      integer xconouv, xinit
      integer xfslvoir_y2k, xfslactv, xselopt, xselup
      integer xconact, iargc
      INTEGER IER
      INTEGER I, J, INF
      character*16 option, valeur
      character*128   nomfich
      integer        recs(MAXRECS)
      integer        indsel, iun
      real pi, pj, dgrw, d60
      integer nbdes
      logical styleflag
      CHARACTER * 16   CLE(41)
      CHARACTER * 128 DEF(41), VAL(41)
      integer lnkdiun(40)
*
      DATA CLE/40*'iment.', 'style'/
      DATA DEF/40*'SCRAP', 'OLDSTYLE'/
      DATA VAL/40*'SCRAP', 'NEWSTYLE'/
*
      DATA lnkdiun / 1, 11, 12, 13, 14, 15, 16, 17, 18, 19,
     *              20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
     *              30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
     *              40, 41, 42, 43, 44, 45, 46, 47, 48, 49 /
      ier = xinit('xvoir')
      nomfich = 'xvoir'
      CALL CCARD(CLE,DEF,VAL,41,-1)
      niun = 1
 33   if (val(niun).ne.'SCRAP') then
         niun = niun +1
         goto 33
      endif
      if (val(41).eq.'NEWSTYLE') then
         styleflag = .true.
      else
         styleflag = .false.
      endif
      niun = niun -1
      do 34 i=1, niun
         IER = FNOM(lnkdiun(i),val(i),'RND+OLD+R/O',0)
         if (ier.lt. 0) then
            print *, '***********************************************'
            print *, '* Probleme d''ouverture avec le fichier ',val(i)
            print *, '************************************************'
            stop
         endif
 34   continue
      nrecs = 0
      do 35 i=1,niun
         ier = FSTOUV(lnkdiun(i), 'RND')
      ier = fstinl(lnkdiun(i), ni, nj, nk, -1, ' ',-1,-1,-1,' ',' ',
     *             liste, nrecs, 24576)
         if (ier.lt.0) then
            print *, '**********************************************'
            print *, '* Le fichier #',val(i), 
     *               'n''est pas standard random'
            print *, '**********************************************'
            stop
         endif
      nbrecs = nbrecs + nrecs
 35   continue
      call fstlnk(lnkdiun, niun)   
      iun = lnkdiun(1)
      option = 'bouton_fermer'
      valeur = 'oui'
      ier = xselopt(iun, option, valeur)
      ier = xfslvoir_y2k(nomfich, iun, nbrecs, 1, 2,styleflag)
 1000 inf = xfslactv(recs, nbrecs, 1)
      ier = xselup(1)
*      do 100 i=1,nbrecs
* 100     print *, i, recs(i)
 2    format(72a)
 4    format(3i16)
 5    format('Fichier: ', 100a)
 6    format(72a)
      IER = FSTFRM(1)
      STOP
      END
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
