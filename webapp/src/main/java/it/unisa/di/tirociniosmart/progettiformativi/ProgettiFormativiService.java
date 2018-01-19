package it.unisa.di.tirociniosmart.progettiformativi;

import it.unisa.di.tirociniosmart.convenzioni.Azienda;
import it.unisa.di.tirociniosmart.convenzioni.AziendaRepository;
import it.unisa.di.tirociniosmart.convenzioni.DelegatoAziendale;
import it.unisa.di.tirociniosmart.convenzioni.IdAziendaEsistenteException;
import it.unisa.di.tirociniosmart.convenzioni.IdAziendaNonValidoException;
import it.unisa.di.tirociniosmart.utenza.AutenticazioneHolder;
import it.unisa.di.tirociniosmart.utenza.RichiestaNonAutorizzataException;
import it.unisa.di.tirociniosmart.utenza.UtenteRegistrato;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * Classe che definisce la logica di business per le operazioni possibili nell'ambito delle
 * della gestione dei progetti formativi di un'azienda.
 *
 * @see ProgettoFormativo
 * @see ProgettoFormativoRepository
 */
public class ProgettiFormativiService {
  
  @Autowired
  private ProgettoFormativoRepository progettoFormativoRepository;
  
  @Autowired
  private AziendaRepository aziendaRepository;

  
  /**
   * Permette di richiedere al sistema il salvataggio di un progetto formativo. La procedura 
   * registra un progetto assegnandogli una {@link Azienda}.
   * 
   * @param progetto {@link Progetto} che si vuole aggiungere tra i progetti dell'azienda.
   * 
   * @pre progetto != null
   */
  @Transactional
  public void aggiungiProgettoFormativo(ProgettoFormativo progetto) throws Exception {
    progetto.setNome(validaNome(progetto.getNome()));
    progetto.setDescrizione(validaDescrizione(progetto.getDescrizione()));
    progetto.setStatus(ProgettoFormativo.ATTIVO);
   
    if (AutenticazioneHolder.getUtente() instanceof DelegatoAziendale) {
      DelegatoAziendale delegato = (DelegatoAziendale) AutenticazioneHolder.getUtente();
      Azienda azienda = delegato.getAzienda();
      progetto.setAzienda(azienda);
    } else {
      throw new RichiestaNonAutorizzataException();
    }
   
    progettoFormativoRepository.save(progetto);
    
  }
  
  
  public List<ProgettoFormativo> elencaProgettiFormativi(String idAzienda) 
      throws RichiestaNonAutorizzataException, IdAziendaNonValidoException {
    if (!aziendaRepository.existsById(idAzienda)) {
      throw new IdAziendaNonValidoException();
    }
    
    List<ProgettoFormativo> progettiFormativi = 
                   progettoFormativoRepository.findAllByStatusAndAziendaId(ProgettoFormativo.ATTIVO,
                                                                           idAzienda);
    
    return progettiFormativi;
  }
 
  
  /**
   * Controlla che il nome di un progetto sia specificato e che la sua lunghezza rispetti 
   * i parametri prestabiliti.
   * 
   * @param nome Stringa che rappresenta il nome da controllare
   * 
   * @return La stringa che rappresenta il nome da controllare bonificata
   * 
   * @throws NomeProgettoNonValidoException se il nome è nullo oppure se la sua lunghezza non 
   *         rientra nell'intervallo che va da {@link UtenteRegistrato#MIN_LUNGHEZZA_NOME} a
   *         {@link UtenteRegistrato#MAX_LUNGHEZZA_NOME}
   */
  public String validaNome(String nome) throws NomeProgettoNonValidoException {
    if (nome == null) {
      throw new NomeProgettoNonValidoException();
    } else {
      nome = nome.trim();
      
      if (nome.length() < UtenteRegistrato.MIN_LUNGHEZZA_NOME
          || nome.length() > UtenteRegistrato.MAX_LUNGHEZZA_NOME) {
        throw new NomeProgettoNonValidoException();
      } else {
        return nome;
      }
    }
  }
  
  /**
   * Controlla che la descrizione di un progetto formativo sia specificato.
   * 
   * @param descrizione Stringa che rappresenta la descrizione da controllare
   * 
   * @return La stringa che rappresenta la descrizione da controllare bonificata
   * 
   * @throws DescrizioneNonValidaException se la descrizione è nulla oppure se la sua lunghezza non 
   *         rientra nell'intervallo che va da {@link UtenteRegistrato#MIN_LUNGHEZZA_DESCRIZIONE} a
   *         {@link UtenteRegistrato#MAX_LUNGHEZZA_DESCRIZIONE}
   */
  public String validaDescrizione(String descrizione) 
        throws DescrizioneNonValidaException {
    if (descrizione == null) {
      throw new DescrizioneNonValidaException();
    } else {
      descrizione = descrizione.trim();
      
      if (descrizione.length() < UtenteRegistrato.MIN_LUNGHEZZA_NOME
          || descrizione.length() > UtenteRegistrato.MAX_LUNGHEZZA_NOME) {
        throw new DescrizioneNonValidaException();
      } else {
        return descrizione;
      }
    }
  }

}
