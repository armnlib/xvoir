      integer function xfslvoir_y2k(nomfich, iun, ttlrecs, winind, 
     $     typesel, styleflag)
      implicit none
      integer ttlrecs,ntmrecs
      character*128 nomfich
      integer iun, winind, typesel
      logical styleflag
      integer ligne,maxrecs,maxdes
      parameter (ligne  = 150)
      parameter (maxrecs= 64)
      parameter (maxdes = 24)
      character*12 idents 
      character*150 tableau
      common /xfscinf/ idents(maxdes), tableau(0:maxrecs)
      integer table, recs,listbuf, nrecs, nbrecs, nbdes
      real liste(1)
      common /xfsiinf/ table(3,maxdes),recs(maxrecs),
     *                 liste(1), listbuf,nrecs, nbrecs, nbdes
      character*4 nomvar
      character*2 typvar
      character*1  grtyp, cdatyp
      character*12 etiket
      character*160  titre
      integer key, date0, deet, npas, ni, nj, nk, nbits, datyp 
      integer ip1, ip2, ip3, swa, lng, dltf, ubc
      integer ig1, ig2, ig3, ig4, extra1, extra2, extra3
      integer fstinf, fstprm, fstsui, fstrwd
      integer fnom, fstfrm, res
      integer xselouv, xseloup, xselins, xselouf
      real xg1, xg2, xg3, xg4
      integer yyyymmdd,hhmmssss
      integer ier
      integer kind
      real p
      character*12 string
      integer i, j, inf
      if (ttlrecs.gt.0) then
         call memoirh(liste, listbuf, ttlrecs)
      endif
*      
      nbdes = 19
      call initidv(idents, maxdes)
      call inittabv(tableau, table, ligne)
      write(titre, 5) nomfich
*      
*      
      res = xseloup(titre, ttlrecs, idents, nbdes, winind, typesel)
      if (ttlrecs.eq.0) then
         res = xselins(table,ttlrecs)
         goto 100
      endif
*      
      i = 0
      ier = fstrwd(iun)
      key = fstinf(iun, ni, nj, nk,  -1, ' ', -1, -1, -1, ' ', ' ')
      if (key.lt.0) goto 100
      i = i+1
*      
*      
      inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,
     *     datyp, ip1, ip2, ip3, typvar, nomvar, etiket, grtyp, 
     *     ig1, ig2, ig3, ig4, swa, lng, dltf, ubc, 
     *     extra1, extra2, extra3)
      if (datyp.eq.0) then
         cdatyp = 'X'
      else
         if (datyp.eq.1) then
            cdatyp = 'R'
         else
            if (datyp.eq.2) then
               cdatyp = 'I'
            else
               cdatyp = 'C'
            endif
         endif
      endif
*      
*      
      if (.not.styleflag) then
         write(tableau(mod(i-1,64)), 10) NOMVAR, TYPVAR, IP1, IP2, IP3,
     *        NI, NJ, NK, ETIKET, DATE0, deet, npas,
     *        grtyp, ig1, ig2, ig3, ig4, 
     *        cdatyp, nbits
      else
         if (grtyp.ne.'Z'.and.grtyp.ne.'Y') then
            call cigaxg(grtyp,xg1,xg2,xg3,xg4,ig1,ig2,ig3,ig4)
         else
            xg1 = ig1
            xg2 = ig2
            xg3 = ig3
            xg4 = ig4
         endif
         call newdate(date0,yyyymmdd,hhmmssss,-3)
         hhmmssss = hhmmssss / 100
         call convip( ip1, p, kind, -1, string, .true.)
         write(tableau(mod(i-1,64)), 11) NOMVAR,TYPVAR,string,IP2,IP3,
     *        NI, NJ, NK, ETIKET,yyyymmdd,hhmmssss, deet, npas,
     *        grtyp, xg1, xg2, xg3, xg4, 
     *        cdatyp, nbits
      endif
      liste(listbuf+i-1) = key
      if (ttlrecs.le.1) then
         res = xselins(table,ttlrecs)
      endif
 50   if (key.lt.0) goto 100
      i = i + 1
*      
*      
      key = fstsui(iun, ni, nj, nk)
      if (key.lt.0) goto 100
      inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,
     *     datyp, ip1, ip2, ip3, typvar, nomvar, etiket, grtyp, 
     *     ig1, ig2, ig3, ig4, swa, lng, dltf, ubc, 
     *     extra1, extra2, extra3)
      if (datyp.eq.0) then
         cdatyp = 'X'
      else
         if (datyp.eq.1) then
            cdatyp = 'R'
         else
            if (datyp.eq.2) then
               cdatyp = 'I'
            else
               cdatyp = 'C'
            endif
         endif
      endif
      if (.not.styleflag) then
         write(tableau(mod(i-1,64)), 10) NOMVAR, TYPVAR, IP1, IP2, IP3,
     *        NI, NJ, NK, ETIKET, DATE0, deet, npas,
     *        grtyp, ig1, ig2, ig3, ig4, 
     *        cdatyp, nbits
      else
         if (grtyp.ne.'Z'.and.grtyp.ne.'Y') then
            call cigaxg(grtyp,xg1,xg2,xg3,xg4,ig1,ig2,ig3,ig4)
         else
            xg1 = ig1
            xg2 = ig2
            xg3 = ig3
            xg4 = ig4
         endif
         call newdate(date0,yyyymmdd,hhmmssss,-3)
         hhmmssss = hhmmssss / 100
         call convip( ip1, p, kind, -1, string, .true.)
         write(tableau(mod(i-1,64)), 11) NOMVAR,TYPVAR,string,IP2,IP3,
     *        NI, NJ, NK, ETIKET,yyyymmdd,hhmmssss, deet, npas,
     *        grtyp, xg1, xg2, xg3, xg4, 
     *        cdatyp, nbits
      endif
      liste(listbuf+i-1) = key
      ntmrecs = mod(i,64)
      if (ntmrecs.eq.0) then
         ntmrecs = 64
      endif
      if (0.eq.mod(i,64).or.i.eq.ttlrecs) then
         res = xselins(table,ntmrecs)
      endif
      goto 50
 100  continue
      res = xselouf(table, ntmrecs)
      xfslvoir_y2k = winind
 2    format(40a)
 4    format(3i16)
 5    format(128a)
 6    format(40a)
 10   FORMAT(A4, X, A2, X, I12, X, I5, X, I5, 
     $     X, I5, X, I5, X, I5, X, A12, X, i15.9,     3X, i5, 2x, i5, 
     $     5x, a1, x, i9, x, i9, x, i9, x, i9, 
     $     3x, a1,i2.2)
 11   FORMAT(A4, X, A2, X, a12, X, I5, X, I5, 
     $     X, I5, X, I5, X, I5, X, A12, X, i8.8,i7.6, 3X, i5, 2x, i5, 
     $     5x, a1, x, f9.1, x, f9.1, x, f9.1, x, f9.1, 
     $     3x, a1,i2.2)
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      integer function xfslferv(winind)
      implicit none
      integer winind
      integer ligne,maxrecs,maxdes
      parameter (ligne  = 150)
      parameter (maxrecs= 64)
      parameter (maxdes = 24)
      character*12 idents 
      character*150 tableau
      common /xfscinf/ idents(maxdes), tableau(0:maxrecs)
      integer table, recs,listbuf, nrecs, nbrecs, nbdes
      real liste(1)
      common /xfsiinf/ table(3,maxdes),recs(maxrecs),
     *                 liste(1), listbuf,nrecs, nbrecs, nbdes
      integer xselfer
      integer i, inf, res
      xfslferv = xselfer(winind)
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      integer function xfslactv(slkeys, nslkeys, winind)
      implicit none
      integer nslkeys
      integer slkeys(nslkeys), winind
      integer ligne,maxrecs,maxdes
      parameter (ligne  = 150)
      parameter (maxrecs= 64)
      parameter (maxdes = 24)
      character*12 idents 
      character*150 tableau
      common /xfscinf/ idents(maxdes), tableau(0:maxrecs)
      integer table, recs,listbuf, nrecs, nbrecs, nbdes
      real liste(1)
      common /xfsiinf/ table(3,maxdes),recs(maxrecs),
     *                 liste(1), listbuf,nrecs, nbrecs, nbdes
      integer xselact
      integer i, inf, res
*      
*      
      xfslactv = xselact(slkeys, nslkeys, winind)
      do 200 i=1, nslkeys
         slkeys(i) = liste(listbuf+slkeys(i)-1)
 200  continue
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      subroutine initidv(idents)
      character*12 idents(*)
      integer i, j, ulng
      integer  getulng
      external getulng
      idents(1) =  'NOMV'
      idents(2)  = 'TV'
      idents(3)  = '      NIV'
      idents(4)  = '  IP2'
      idents(5)  = '  IP3'
      idents(6)  = '   NI'
      idents(7)  = '   NJ'
      idents(8)  = '   NK'
      idents(9)  = 'ETIQUETTE'
      idents(10) = 'YYYYMMDD'
      idents(11) = ' HHMMSS'
      idents(12) = '   DEET'
      idents(13) = '   NPAS'
      idents(14) = '  G'
      idents(15) = '       IG1'
      idents(16) = '       IG2'
      idents(17) = '       IG3'
      idents(18) = '       IG4'
      idents(19) = 'DTY'
      return
      end
*****************************************************************
      subroutine inittabv(tableau, table, len)
      character*150 tableau(*)
      integer table(3, *)
      integer len
      integer sumlen
      integer i
      integer reclen(20)
      data reclen /5,3,13,6,
     $     6,6,6,6,
     $     13,8,8,7,
     $     10,3,10,10,
     $     10,13,3,0/
      sumlen       = 0
      do i=1,20
         table(1,i)   = reclen(i)
         table(2,i)   = len
         table(3,i)   = loc(tableau(1)) +sumlen
         sumlen       = sumlen + table(1,i)
      enddo
      return 
      end
c     ****************************************************************
      integer function xfslupdv(nomfich, iun, ttlrecs, winind, typesel)
      implicit none
      integer ttlrecs,ntmrecs,typesel
      character*(*) nomfich
      integer iun, winind
      integer ligne,maxrecs,maxdes
      parameter (ligne  = 150)
      parameter (maxrecs= 64)
      parameter (maxdes = 24)
      character*12 idents 
      character*150 tableau
      common /xfscinf/ idents(maxdes), tableau(0:maxrecs)
      integer table, recs,listbuf, nrecs, nbrecs, nbdes
      real liste(1)
      common /xfsiinf/ table(3,maxdes),recs(maxrecs),
     *                 liste(1), listbuf,nrecs, nbrecs, nbdes
      call memoirh(liste, listbuf, 0)
      call xselupd(winind)
      call xfslvoir_y2k(nomfich, iun, ttlrecs, winind, typesel)
      return
      end
c     ****************************************************************
